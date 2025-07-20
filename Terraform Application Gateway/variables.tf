
variable "resource_group_name" {
  description = "The name of the existing resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "vnet_name" {
  description = "The name of the existing virtual network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the existing subnet"
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR block of the existing subnet"
  type        = string
}
