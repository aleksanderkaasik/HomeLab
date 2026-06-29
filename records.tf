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
  ptr  = dns_a_record_set.proxmox.id
  ttl  = 300
} 

resource "dns_a_record_set" "pki" {
  zone = var.dns_zones["Main"]
  name = "pki"
  addresses = [
    "192.168.1.41",
  ]
  ttl = 300
}

resource "dns_ptr_record" "pki_ptr" {
  zone = var.dns_zones["192.168.1.0"]
  name = "41"
  ptr  = dns_a_record_set.pki.id
  ttl  = 300
}

resource "dns_a_record_set" "vault" {
  zone = var.dns_zones["Main"]
  name = "vault"
  addresses = [
    "192.168.1.52",
  ]
  ttl = 300
}

resource "dns_ptr_record" "vault_ptr" {
  zone = var.dns_zones["192.168.1.0"]
  name = "52"
  ptr  = dns_a_record_set.vault.id
  ttl  = 300
}

resource "dns_a_record_set" "blog" {
  zone = var.dns_zones["Blog"]
  name = "aleksander"
  addresses = [
    "192.168.1.49",
  ]
  ttl = 300
}

resource "dns_ptr_record" "blog_ptr" {
  zone = var.dns_zones["192.168.1.0"]
  name = "49"
  ptr  = dns_a_record_set.blog.id
  ttl  = 300
}

resource "dns_a_record_set" "panel" {
  zone = var.dns_zones["Main"]
  name = "game-panel"
  addresses = [
    "192.168.1.43"
  ]
  ttl = 300
}

resource "dns_ptr_record" "panel_ptr" {
  zone = var.dns_zones["192.168.1.0"]
  name = "43"
  ptr  = dns_a_record_set.panel.id
  ttl  = 300
}

resource "dns_a_record_set" "wing" {
  zone = var.dns_zones["Main"]
  name = "wing"
  addresses = [
    "192.168.1.50"
  ]
  ttl = 300
}

resource "dns_ptr_record" "wing_ptr" {
  zone = var.dns_zones["192.168.1.0"]
  name = "50"
  ptr  = dns_a_record_set.wing.id
  ttl  = 300
}

resource "dns_a_record_set" "zabbix" {
  zone = var.dns_zones["Main"]
  name = "monitor"
  addresses = [
    "192.168.1.42"
  ]
  ttl = 300
}

resource "dns_ptr_record" "zabbix_ptr" {
  zone = var.dns_zones["192.168.1.0"]
  name = "42"
  ptr  = dns_a_record_set.zabbix.id
  ttl  = 300
}

resource "dns_a_record_set" "cloud" {
  zone = var.dns_zones["Main"]
  name = "cloud"
  addresses = [
    "192.168.1.3"
  ]
  ttl = 300
}

resource "dns_ptr_record" "cloud_ptr" {
  zone = var.dns_zones["192.168.1.0"]
  name = "3"
  ptr  = dns_a_record_set.cloud.id
  ttl  = 300
}


resource "dns_a_record_set" "aero_test" {
  zone = var.dns_zones["Main"]
  name = "aerotest"
  addresses = [
    "192.168.1.46"
  ]
  ttl = 300
}

resource "dns_a_record_set" "aeropack_test" {
  zone = var.dns_zones["Main"]
  name = "aeropack"
  addresses = [
    "192.168.1.46"
  ]
  ttl = 300
}

resource "dns_a_record_set" "zombieskytest" {
  zone = var.dns_zones["Main"]
  name = "zombieskytest"
  addresses = [
    "192.168.1.46"
  ]
  ttl = 300
}

resource "dns_a_record_set" "zombiepack" {
  zone = var.dns_zones["Main"]
  name = "zombiepack"
  addresses = [
    "192.168.1.46"
  ]
  ttl = 300
}

resource "dns_a_record_set" "zombiesky" {
  zone = var.dns_zones["Main"]
  name = "zombiesky"
  addresses = [
    "192.168.1.46"
  ]
  ttl = 300
}

resource "dns_a_record_set" "vanilla" {
  zone = var.dns_zones["Main"]
  name = "vanilla"
  addresses = [
    "192.168.1.46"
  ]
  ttl = 300
}

# Cloudflare records
resource "cloudflare_dns_record" "Main_origin" {
  zone_id = var.zones["Main"]
  name    = "@"
  ttl     = 1
  type    = "A"
  comment = "Domain verification record"
  content = local.home_ip
  proxied = false
}

resource "cloudflare_dns_record" "cloud" {
  zone_id = var.zones["Main"]
  name    = "cloud"
  ttl     = 1
  type    = "CNAME"
  comment = "Domain verification record"
  content = cloudflare_dns_record.Main_origin.name
  proxied = true
}

resource "cloudflare_dns_record" "gamepanel" {
  zone_id = var.zones["Main"]
  name    = "game-panel"
  ttl     = 1
  type    = "CNAME"
  comment = "Domain verification record"
  content = cloudflare_dns_record.Main_origin.name
  proxied = true
}

resource "cloudflare_dns_record" "blog_origin" {
  zone_id = var.zones["Blog"]
  name    = "@"
  ttl     = 1
  type    = "A"
  comment = "Domain verification record"
  content = local.home_ip
  proxied = false
}

resource "cloudflare_dns_record" "MainBlog" {
  zone_id = var.zones["Blog"]
  name    = "aleksander"
  ttl     = 1
  type    = "CNAME"
  comment = "Domain verification record"
  content = cloudflare_dns_record.blog_origin.name
  proxied = false
}

resource "cloudflare_dns_record" "wing" {
  zone_id = var.zones["Main"]
  name    = "wing"  
  ttl     = 1
  type    = "CNAME"
  comment = "Domain verification record"
  content = cloudflare_dns_record.Main_origin.name
  proxied = false
}


resource "cloudflare_dns_record" "aero_test" {
  zone_id = var.zones["Main"]
  name    = "aerotest"
  ttl     = 1
  type    = "CNAME"
  comment = "Domain verification record"
  content = cloudflare_dns_record.Main_origin.name
  proxied = false
}

resource "cloudflare_dns_record" "aeropack_test" {
  zone_id = var.zones["Main"]
  name    = "aeropack"
  ttl     = 1
  type    = "CNAME"
  comment = "Domain verification record"
  content = cloudflare_dns_record.Main_origin.name
  proxied = false
}

resource "cloudflare_dns_record" "zombieskypack" {
  zone_id = var.zones["Main"]
  name    = "zombieskytest"  
  ttl     = 1
  type    = "CNAME"
  comment = "Domain verification record"
  content = cloudflare_dns_record.Main_origin.name
  proxied = false
}

resource "cloudflare_dns_record" "ZombieSky" {
  zone_id = var.zones["Main"]
  name    = "zombiesky"  
  ttl     = 1
  type    = "CNAME"
  comment = "Domain verification record"
  content = cloudflare_dns_record.Main_origin.name
  proxied = false
}

resource "cloudflare_dns_record" "Vanilla" {
  zone_id = var.zones["Main"]
  name    = "vanilla"  
  ttl     = 1
  type    = "CNAME"
  comment = "Domain verification record"
  content = cloudflare_dns_record.Main_origin.name
  proxied = false
}
