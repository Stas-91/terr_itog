variable "vm_config" {
  description = "Configuration object for the virtual machine"
  type = object({
    vm_name            = string
    platform_id        = string
    zone               = string
    labels             = map(string)
    cores              = number
    memory             = number
    disk_size          = number
    disk_type          = string
    nat_enable         = bool
    serial_port_enable = number
    image_family       = string
    preemptible        = bool
  })
  default = {
    vm_name            = "default-vm"
    platform_id        = "standard-v3"
    zone               = "ru-central1-a"
    labels             = {}
    cores              = 2
    memory             = 4
    disk_size          = 20
    disk_type          = "network-ssd"
    nat_enable         = false
    serial_port_enable = 0
    image_family       = "ubuntu-2004-lts"
    preemptible        = false
  }
}

variable "folder_id" {
  description = "Folder ID where the VM will be created"
  type        = string
}

variable "cloudinit" {
  description = "Cloud-init user data for VM initialization"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the VM network interface"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the VM"
  type        = list(string)
}