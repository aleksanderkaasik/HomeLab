ansible-playbook lxc_setup.yml -u root
ansible-playbook bind9.yml

ansible all -m reboot --become

ansible-playbook mysql.yml

ansible-playbook pki.yml

ansible-playbook importing_ca_crt.yml

ansible-playbook vaultwarden.yml
ansible-playbook wordpress.yml
ansible-playbook nextcloud.yml

ansible-playbook pterodactyl_panel.yml
# ansible-playbook pterodactyl_wing.yml

ansible-playbook zabbix_server.yml
# ansible-playbook zabbix_agent.yml

# ansible-playbook snmp.yml

ansible-playbook haproxy_reverse_proxy.yml
ansible-playbook nginx_reverse_proxy.yml
