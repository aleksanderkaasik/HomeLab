terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc05"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://a.b.c.d:8006/api2/json"
  pm_api_token_id     = "user@pam!name"
  pm_api_token_secret = "secrettoken123@"
  pm_tls_insecure     = true
}

resource "proxmox_lxc" "test" {
  target_node     = "ProxmoxHost"
  hostname        = "test"
  ostemplate      = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  password        = "Password"
  unprivileged    = true
  start           = true
  cores           = 2
  memory          = 4096
  tags            = "test;ubuntu"
  ssh_public_keys = "SSHkey"
  onboot = true

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    ip       = "dhcp"
    firewall = false
  }

  features {
    nesting = true
  }

  rootfs {
    storage = "VM-Storage"
    size    = "16G"
  }

  lifecycle {
    ignore_changes = [
      ostemplate,
      password,
      ssh_public_keys
    ]
  }
}
