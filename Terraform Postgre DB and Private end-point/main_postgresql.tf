# Data source for existing Virtual Network
data "azurerm_virtual_network" "example" {
  name                = "UPLApps-CI-AVD-VNET-01"
  resource_group_name = var.resource_group_name
}

# Data source for existing delegated Subnet
data "azurerm_subnet" "postgresql_dedicated" {
  name                 = "UPLAPPS_Postgresql_Subnet"
  virtual_network_name = data.azurerm_virtual_network.example.name
  resource_group_name  = var.resource_group_name
}

# PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "example" {
  name                   = var.server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.postgresql_version
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  sku_name               = var.sku_name
  storage_mb             = var.storage_in_gb * 1024
  zone                   = null
  public_network_access_enabled = false

  backup_retention_days        = 30
  geo_redundant_backup_enabled = var.geo_redundancy

  delegated_subnet_id = data.azurerm_subnet.postgresql_dedicated.id
  private_dns_zone_id = var.private_dns_zone_id

  tags = {
    Environment = "Production"
  }
}
