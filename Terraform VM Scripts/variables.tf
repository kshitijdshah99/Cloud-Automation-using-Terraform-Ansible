variable "resource_group_name" {
  type = string
  description = "This is a resource group"
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "vnet_resource_group_name" {
  type = string
}

variable "vnet_address_space" {
  type = string
}

variable "subnet_address_prefix" {
  type = string
}

variable "nic_name" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "nsg_name" {
  type = string
}

variable "os_disk_size" {
  type = number
}

variable "os_disk_type" {
  type = string
}

variable "enable_accelerated_networking" {
  type = bool
}
