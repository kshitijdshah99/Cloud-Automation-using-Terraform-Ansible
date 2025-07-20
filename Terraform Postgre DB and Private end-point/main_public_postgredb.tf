
# Data source for existing Virtual Network
data "azurerm_virtual_network" "example" {
  name                = "UPLApps-CI-AVD-VNET-01"
  resource_group_name = var.resource_group_name
}

# Data source for existing Subnet (non-dedicated)
data "azurerm_subnet" "postgresql_pe_subnet" {
  name                 = "UPLApps-CI-AVD-Subnet-01"
  virtual_network_name = data.azurerm_virtual_network.example.name
  resource_group_name  = var.resource_group_name
}

# PostgreSQL Flexible Server (Public)
resource "azurerm_postgresql_flexible_server" "public" {
  name                   = var.server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.postgresql_version
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  sku_name               = var.sku_name
  storage_mb             = var.storage_in_gb * 1024
  zone                   = null
  public_network_access_enabled = true

  backup_retention_days        = 30
  geo_redundant_backup_enabled = var.geo_redundancy

  tags = {
    Environment = "Production"
  }
}

# Private Endpoint for PostgreSQL
resource "azurerm_private_endpoint" "postgresql_pe" {
  name                = "${var.server_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.postgresql_pe_subnet.id

  private_service_connection {
    name                           = "${var.server_name}-psc"
    private_connection_resource_id = azurerm_postgresql_flexible_server.public.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }
}

# Private DNS Zone Association
# resource "azurerm_private_dns_zone_virtual_network_link" "postgresql_dns_link" {
#   name                  = "postgresql-dns-link"
#   resource_group_name   = var.resource_group_name
#   private_dns_zone_name = var.private_dns_zone_id
#   virtual_network_id    = data.azurerm_virtual_network.example.id
#   registration_enabled  = false
# }

resource "azurerm_private_dns_zone_virtual_network_link" "postgresql_dns_link" {
  name                  = "postgresql-dns-link"
  resource_group_name   = "UPLAPPS-INC-PRD-RG-01"  # ✅ Correct resource group where this DNS zone belongs
  private_dns_zone_name = "privatelink.postgres.database.azure.com"
  virtual_network_id    = data.azurerm_virtual_network.example.id
  registration_enabled  = false
}

