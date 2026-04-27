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

# Cloudflare records
resource "cloudflare_dns_record" "Main_origin" {
  zone_id = var.zones["Main"]
  name = "@"
  ttl = 1
  type = "A"
  comment = "Domain verification record"
  content = local.home_ip
  proxied = true
}

resource "cloudflare_dns_record" "vault" {
  zone_id = var.zones["Main"]
  name = "vault"
  ttl = 1
  type = "CNAME"
  comment = "Domain verification record"
  content = cloudflare_dns_record.Main_origin.name
  proxied = true
}

resource "cloudflare_dns_record" "cloud" {
  zone_id = var.zones["Main"]
  name = "cloud"
  ttl = 1
  type = "CNAME"
  comment = "Domain verification record"
  content = cloudflare_dns_record.Main_origin.name
  proxied = true
}

resource "cloudflare_dns_record" "blog_origin" {
  zone_id = var.zones["Blog"]
  name = "@"
  ttl = 1
  type = "A"
  comment = "Domain verification record"
  content = local.home_ip
  proxied = true
}

resource "cloudflare_dns_record" "blog" {
  zone_id = var.zones["Blog"]
  name = "www"
  ttl = 1
  type = "CNAME"
  comment = "Domain verification record"
  content = cloudflare_dns_record.blog_origin.name
  proxied = true
}
