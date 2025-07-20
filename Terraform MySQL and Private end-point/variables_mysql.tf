variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "mysql_server_name" {
  description = "Name of the MySQL server"
  type        = string
}

variable "admin_username" {
  description = "Administrator username for MySQL"
  type        = string
}

variable "admin_password" {
  description = "Administrator password for MySQL"
  type        = string
  sensitive   = true
}

variable "vnet_name" {
  description = "Name of the existing virtual network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the existing subnet"
  type        = string
}
