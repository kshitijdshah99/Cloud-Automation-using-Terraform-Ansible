data "azurerm_virtual_network" "existing_vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "existing_subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_public_ip" "public_ip" {
  name                = "appgw-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "appgw" {
  name                = "myAppGateway"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = data.azurerm_subnet.existing_subnet.id
  }

  frontend_port {
    name = "frontendPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "appgw-fe-ip"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  backend_address_pool {
    name = "appgw-backend-pool"
  }

  backend_http_settings {
    name                  = "appgw-backend-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = "appgw-http-listener"
    frontend_ip_configuration_name = "appgw-fe-ip"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }

  request_routing_rule {
  name                       = "rule1"
  rule_type                  = "Basic"
  http_listener_name         = "appgw-http-listener"
  backend_address_pool_name  = "appgw-backend-pool"
  backend_http_settings_name = "appgw-backend-http-settings"
  priority                   = 100
}
}