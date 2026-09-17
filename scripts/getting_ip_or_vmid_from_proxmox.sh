#!/bin/bash

proxmox_host="$1"
proxmox_token_id="$2"
proxmox_token_secret="$3"
proxmox_node="$4"
vmid="$5"

proxmox_header="Authorization: PVEAPIToken=${proxmox_token_id}=${proxmox_token_secret}"
proxmox_url="https://$proxmox_host:8006/api2/json/nodes/$proxmox_node/lxc"

if [[ -z $vmid ]]; then
  vmid=$(curl -sk \
    -H "$proxmox_header" \
    "$proxmox_url" | jq -r '[.data[].vmid]'
  )

  jq -n --arg vmids "$vmid" '{"vmids": $vmids}'
else
  ip_address=$(
  curl -sk \
    -H "$proxmox_header" \
    "$proxmox_url/$vmid/interfaces" |
    jq -r '.data[] | 
      select(.name == "eth0") | 
      ."ip-addresses"[] | 
      select(."ip-address-type" != "inet6") | 
      ."ip-address"'
  )

  jq -n --arg ip "$ip_address" '{"ip": $ip_address}'
fi
