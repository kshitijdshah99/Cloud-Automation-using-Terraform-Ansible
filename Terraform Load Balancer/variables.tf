variable "name" {
  description = "Name of the Load Balancer"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sku" {
  description = "SKU of the Load Balancer"
  type        = string
}

variable "tier" {
  description = "Tier of the Load Balancer"
  type        = string
}
