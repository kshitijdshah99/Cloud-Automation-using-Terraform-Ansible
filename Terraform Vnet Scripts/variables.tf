variable "resource_group_name" {
  description = "The name of the existing resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the existing resource group is located"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "A map of subnet names to their address prefixes"
  type        = map(string)
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}
