variable "proxmox_api_url" {
  type        = string
  description = "Base URL of the Proxmox Virtual Environment API (e.g. https://proxmox.example.com:8006/api2/json)."
}

variable "proxmox_api_token_id" {
  type        = string
  description = "API token ID used to authenticate against the Proxmox API (format: user@realm!tokenid)."
  sensitive   = true
}

variable "proxmox_api_token_secret" {
  type        = string
  description = "Secret value associated with the Proxmox API token ID."
  sensitive   = true
}

variable "proxmox_vm_password" {
  type        = string
  description = "Initial password to configure for the VM's default user account."
  sensitive   = true
}

variable "public_ssh_key" {
  type        = string
  description = "Public SSH key that will be injected into the VM for key-based authentication."
  sensitive   = true
}

variable "os_image" {
  type        = string
  description = "path of the OS image to use when creating the VM."
}

variable "proxmox_node_name" {
  type        = string
  description = "Name of the Proxmox node within the cluster where the VM will be deployed."
  default     = "proxmoxHost"
}

variable "proxmox_node_tls_insecure" {
  type        = bool
  description = "By default Proxmox Virtual Environment uses self-signed certificates."
  default     = true
}

variable "dns_zones" {
  type        = map(string)
  description = "A mapping of domain names or network ranges to DNS zones. Used to determine where forward and reverse DNS records should be created."
  default = {
    "test"        = "test.home."
    "192.168.1.0" = "1.168.192.in-addr.arpa.",
  }
}

variable "cloudflare_dns_api_token" {
  type = string
  default = "API token"
}

variable "zones" {
  type = map(string)
  default = {
    "zone" = "id"
  }
}

variable "dns_server_host" {
  type        = string
  description = "Hostname or IP address of the DNS server that will receive dynamic DNS updates."
}

variable "tsig_key_name" {
  type        = string
  description = "Name of the TSIG key used to authenticate dynamic DNS update requests."
}

variable "tsig_key_algorithm" {
  type        = string
  description = "Algorithm used by the TSIG key for signing DNS update requests (e.g. hmac-sha256)."
  default     = "hmac-sha256"
}

variable "tsig_key_secret" {
  type        = string
  description = "Base64-encoded secret associated with the TSIG key used for secure DNS updates."
  sensitive   = true
}

