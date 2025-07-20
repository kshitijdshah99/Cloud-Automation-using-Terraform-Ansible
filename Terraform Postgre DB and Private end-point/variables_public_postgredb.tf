variable "subscription_id" {
  description = "The subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region"
  type        = string
}

variable "server_name" {
  description = "The name of the PostgreSQL server"
  type        = string
}

variable "postgresql_version" {
  description = "The PostgreSQL version"
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL server"
  type        = string
}

variable "vcpu_count" {
  description = "The number of vCPUs"
  type        = number
}

variable "memory_in_gb" {
  description = "The amount of memory in GB"
  type        = number
}

variable "storage_in_gb" {
  description = "The amount of storage in GB"
  type        = number
}

variable "administrator_login" {
  description = "The administrator login name"
  type        = string
}

variable "administrator_password" {
  description = "The administrator password"
  type        = string
  sensitive   = true
}

variable "geo_redundancy" {
  description = "Enable geo-redundant backups"
  type        = bool
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone"
  type        = string
}
