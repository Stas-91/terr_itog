###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

# SSH Configurations
variable "vms_ssh_root_key" {
  type = string
}


# VPC Configurations
variable "vpc_configs" {
  default = {
    dev = {
      network_name = "develop"
      subnets = [
        { zone = "ru-central1-a", cidr = "10.0.1.0/24" }
      ]
    }
    prod = {
      network_name = "production"
      subnets = [
        { zone = "ru-central1-a", cidr = "10.1.1.0/24" },
        { zone = "ru-central1-b", cidr = "10.1.2.0/24" },
        { zone = "ru-central1-d", cidr = "10.1.3.0/24" }
      ]
    }
  }
}

# VM Configurations
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
    vm_name            = "my-vm"
    platform_id        = "standard-v3"
    zone               = "ru-central1-a"
    labels             = {}
    cores              = 2
    memory             = 2
    disk_size          = 10
    disk_type          = "network-ssd"
    nat_enable         = true
    serial_port_enable = 0
    image_family       = "ubuntu-2004-lts"
    preemptible        = true
  }
}

# VM Common Configurations
variable "vm_common" {
  default = {
    username      = "ubuntu"
    packages      = ["vim"]
    # runcmd        = "runcmd:\n  - [ systemctl, enable, nginx ]\n  - [ systemctl, start, nginx ]"
    # image_family  = "ubuntu-2004-lts"
    # serial_port_enable = 1
  }
}


# MySQL Configuration
variable "mysql_config" {
  default = {
    cluster_name   = "example"
    ha             = false
    database_name  = "test"
    username       = "app"
    password       = "Qwerty123"
    user_roles     = ["ALL"]
  }
}

# reegistry Configuration
variable "registry_name" {
  description = "Registry name (unique, 3-63 characters, lowercase letters, numbers, and hyphens only)"
  type        = string
  default     = "my-registry1"
}

# Lockbox Configuration
variable "lockbox_password" {
  type        = string
  description = "Password for the lockbox"
  sensitive   = true
  }