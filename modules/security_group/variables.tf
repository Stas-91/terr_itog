variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "network_id" {
  description = "ID of the network"
  type        = string
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
}

variable "security_group_ingress" {
  description = "Security rules for ingress"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
  default = [
    {
      protocol       = "TCP"
      description    = "Allow incoming SSH"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 22
    },
    {
      protocol       = "TCP"
      description    = "Allow incoming HTTP"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 80
    },
    {
      protocol       = "TCP"
      description    = "Allow incoming HTTPS"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 443
    },
    {
      protocol       = "TCP"
      description    = "Allow incoming app port"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 5000
    },    
  ]
}

variable "security_group_egress" {
  description = "Security rules for egress"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
  default = [
    {
      protocol       = "TCP"
      description    = "Allow all outgoing traffic"
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port      = 0
      to_port        = 65365
    }
  ]
}