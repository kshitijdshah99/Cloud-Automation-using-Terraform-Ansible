variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location of the resource group."
  type        = string
}

variable "account_tier" {
  description = "The performance tier of the storage account."
  type        = string
}

variable "account_replication_type" {
  description = "The replication type of the storage account."
  type        = string
}

variable "https_traffic_only_enabled" {
  description = "Enable HTTPS traffic only."
  type        = bool
}

variable "min_tls_version" {
  description = "Minimum TLS version."
  type        = string
}

variable "access_tier" {
  description = "Blob storage access tier."
  type        = string
}

variable "default_action" {
  description = "Default network rule action."
  type        = string
}
