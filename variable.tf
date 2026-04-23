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
  default = "proxmoxHost"
}

variable "proxmox_node_tls_insecure" {
  type        = bool
  description = "By default Proxmox Virtual Environment uses self-signed certificates."
  default = true
}
