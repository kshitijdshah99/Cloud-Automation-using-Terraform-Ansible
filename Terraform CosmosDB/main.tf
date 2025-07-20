resource "azurerm_cosmosdb_account" "example" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  automatic_failover_enabled = true

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  backup {
    type = "Periodic"

    interval_in_minutes  = 1440
    retention_in_hours   = 168
    storage_redundancy   = "Local"
  }

  capabilities {
    name = "EnableServerless"
  }

  tags = {
    defaultExperience      = var.defaultExperience
    hidden-workload-type   = "Development/Testing"
    hidden-cosmos-mmspecial = ""
  }
}


resource "azurerm_private_endpoint" "cosmosdb_endpoint" {
  name                = "cosmosdb-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "cosmosdb-privateserviceconnection"
    private_connection_resource_id = azurerm_cosmosdb_account.example.id
    subresource_names              = ["Sql"]
    is_manual_connection           = false
  }
}
