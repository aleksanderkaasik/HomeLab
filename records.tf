# DNS records
resource "dns_a_record_set" "proxmox" {
  zone = var.dns_zones["Main"]
  name = "proxmox"
  addresses = [
    "192.168.1.253",
  ]
  ttl = 300
}

resource "dns_ptr_record" "proxmox_ptr" {
  zone = var.dns_zones["192.168.1.0"]
  name = "253"
  ptr  = "proxmox.test.home."
  ttl  = 300
}

# hosts
resource "dns_a_record_set" "pki" {
  zone = var.dns_zones["Main"]
  name = "pki"
  addresses = []
  ttl = 300
}

resource "dns_a_record_set" "vault" {
  zone = var.dns_zones["Main"]
  name = "vault"
  addresses = []
  ttl = 300
}

resource "dns_a_record_set" "blog" {
  zone = var.dns_zones["Blog"]
  name = "www"
  addresses = []
  ttl = 300
}

resource "dns_a_record_set" "panel" {
  zone = var.dns_zones["Main"]
  name = "game-panel"
  addresses = []
  ttl = 300
}

resource "dns_a_record_set" "wing" {
  zone = var.dns_zones["Main"]
  name = "wing"
  addresses = []
  ttl = 300
}

resource "dns_a_record_set" "zabbix" {
  zone = var.dns_zones["Main"]
  name = "monitor"
  addresses = []
  ttl = 300
}

resource "dns_a_record_set" "cloud" {
  zone = var.dns_zones["Main"]
  name = "cloud"
  addresses = []
  ttl = 300
}
