resource_group_name = "UPLApps-CI-AVD-RG-01"
location            = "Central India"
vnet_name           = "example-vnet"
address_space       = ["10.0.0.0/16"]

subnets = {
  "subnet1" = "10.0.1.0/24"
  "subnet2" = "10.0.2.0/24"
  "subnet3" = "10.0.3.0/24"
}

tags = {    
environment = "production"
owner = "team-network"
project = "vnet-deployment"
}
