terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc05"
    }
    dns = {
      source  = "hashicorp/dns"
      version = "3.4.3"
    }

    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "5.15.0"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure     = var.proxmox_node_tls_insecure
}

provider "dns" {
  update {
    server        = var.dns_server_host
    key_name      = var.tsig_key_name
    key_algorithm = var.tsig_key_algorithm
    key_secret    = var.tsig_key_secret
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_dns_api_token
}

data "http" "my_ip" {
  url = "https://ifconfig.me/ip"
}

locals {
  home_ip = trimspace(data.http.my_ip.response_body)
}
