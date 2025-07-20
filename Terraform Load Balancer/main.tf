resource "azurerm_lb" "example" {
  name                = var.name
  location            = var.location
  resource_group_name = "UPLApps-CI-AVD-RG-01"
  sku                 = var.sku
  # tier                = var.tier

  frontend_ip_configuration {
    name                          = "testloadpublicip"
    subnet_id                     = "/subscriptions/a122f7bd-3fa7-4118-b809-fe7496405896/resourceGroups/UPLApps-CI-AVD-RG-01/providers/Microsoft.Network/virtualNetworks/UPLApps-CI-AVD-VNET-01/subnets/UPLApps-CI-AVD-Subnet-01"
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Department = "Production"
  }
}

resource "azurerm_lb_backend_address_pool" "example" {
  name            = "testbackendpoolvms"
  loadbalancer_id = azurerm_lb.example.id
}

resource "azurerm_network_interface_backend_address_pool_association" "example" {
  network_interface_id    = "/subscriptions/a122f7bd-3fa7-4118-b809-fe7496405896/resourceGroups/UPLApps-CI-AVD-RG-01/providers/Microsoft.Network/networkInterfaces/testnic3"
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
}

resource "azurerm_lb_probe" "example" {
  name                = "http-probe"
  # resource_group_name = "UPLApps-CI-AVD-RG-01"
  loadbalancer_id     = azurerm_lb.example.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_nat_rule" "example" {
  name                           = "ssh-nat-rule"
  resource_group_name            = "UPLApps-CI-AVD-RG-01"
  loadbalancer_id                = azurerm_lb.example.id
  protocol                       = "Tcp"
  frontend_port                  = 50001
  backend_port                   = 22
  frontend_ip_configuration_name = "testloadpublicip"
}
