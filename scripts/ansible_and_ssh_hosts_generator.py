import requests
import urllib3
import json
import socket

# Disable insecure warnings (optional)
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

modes = ["host", "ssh", "nick"]

proxmox_host = ""
username = ""
password = ""
node = ""
# use list in modes variable
print_mode = ""

if print_mode not in modes:
    exit()
    
ticketUrl = f"https://{proxmox_host}:8006/api2/json/access/ticket"
payload = {"username": username, "password": password}

responseTicket = requests.post(ticketUrl, data=payload, verify=False)
responseTicket.raise_for_status()

cookies = {"PVEAuthCookie": responseTicket.json()["data"]["ticket"]}

content =json.loads(open("terraform.tfstate", "r").read())

vmidList = []
for x in range( len( content["resources"] )):
    if content["resources"][x]["type"] != "proxmox_lxc":
        continue
    
    for y in range( len( content["resources"][x]["instances"] )):
        answer = ""
        vmID = content["resources"][x]["instances"][y]["attributes"]["vmid"]
        configUrl = f"https://{proxmox_host}:8006/api2/json/nodes/{node}/lxc/{vmID}/config" 
        interfaceUrl = f"https://{proxmox_host}:8006/api2/json/nodes/{node}/lxc/{vmID}/interfaces"
        
        responseConfig = requests.get(configUrl, cookies=cookies, verify=False)
        responseInterfaces = requests.get(interfaceUrl, cookies=cookies, verify=False)
        
        responseConfig.raise_for_status()
        responseInterfaces.raise_for_status()
        
        config = responseConfig.json()["data"]["hostname"]
        ipAdresss = responseInterfaces.json()["data"][1]["ip-addresses"][0]["ip-address"]
        
        try:
            hostname, aliases, addresses = socket.gethostbyaddr(ipAdresss)
        except socket.herror:
            hostname = ipAdresss
        
        host = content["resources"][x]["name"]
        nick = content['resources'][x]['instances'][y]['attributes']['hostname']

        match print_mode.lower():
            case "host":
                if y == 0:
                    print(f"\n[{host}]")
                answer = f"{hostname}"

            case "ssh":
                answer = f"Host {host}\n    HostName {hostname}\n    User ansible\n    Port 22\n    IdentityFile ~/.ssh/ansible"
                
            case "nick":
                if y == 0:
                    print(f"\n[{host}]")
                answer = f"{nick} ansible_host={hostname}"

        print(answer)
