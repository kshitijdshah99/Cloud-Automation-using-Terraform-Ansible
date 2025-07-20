resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_vm_size
  }

  role_based_access_control_enabled = var.enable_rbac

#   addon_profile {
#     http_application_routing_enabled = false
#   }
  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}
