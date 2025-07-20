data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_mysql_flexible_server" "mysql" {
  name                   = var.mysql_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.admin_username
  administrator_password = var.admin_password
  version                = "8.0.21"
  sku_name = "GP_Standard_D2ds_v4"
  zone                   = "1"
#   public_network_access_enabled = false

  storage {
    size_gb           = 20
    auto_grow_enabled = true
  }

  high_availability {
    mode = "ZoneRedundant"
  }
}

resource "azurerm_private_dns_zone" "mysql_dns" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql_dns_link" {
  name                  = "mysql-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.mysql_dns.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
}

resource "azurerm_private_endpoint" "mysql_pe" {
  name                = "${var.mysql_server_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "${var.mysql_server_name}-privatesc"
    private_connection_resource_id = azurerm_mysql_flexible_server.mysql.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "mysql-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.mysql_dns.id]
  }
}

