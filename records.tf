# Default
resource "dns_a_record_set" "proxmox" {
  zone = var.dns_zones["test"]
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
