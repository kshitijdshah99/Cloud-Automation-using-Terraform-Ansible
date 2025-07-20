variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
}

variable "aks_cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
}

variable "node_vm_size" {
  description = "VM size for the AKS nodes"
  type        = string
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the AKS cluster"
  type        = string
}

variable "enable_rbac" {
  description = "Enable Role-Based Access Control"
  type        = bool
}

variable "enable_http_application_routing" {
  description = "Enable HTTP Application Routing add-on"
  type        = bool
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
