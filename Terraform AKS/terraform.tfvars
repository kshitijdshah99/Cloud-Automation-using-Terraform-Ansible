resource_group_name              = ""
location                         = "Central India"
aks_cluster_name                 = "testaks1"
dns_prefix                       = "testaks10"
node_count                       = 3
node_vm_size                     = "Standard_DS2_v2"
kubernetes_version               = "1.33.0"
enable_rbac                      = true
enable_http_application_routing = false
tags = {
  Environment = "Dev"
  Owner       = "Terraform"
}
