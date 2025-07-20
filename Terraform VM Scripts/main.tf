# resource "azurerm_virtual_network" "vnet" {
#   name                = var.vnet_name
#   address_space       = [var.vnet_address_space]
#   location            = var.location
#   resource_group_name = var.resource_group_name
# }

# resource "azurerm_subnet" "subnet" {
#   name                 = var.subnet_name
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = [var.subnet_address_prefix]
# }
# resource "azurerm_virtual_machine_extension" "enable_winrm" {
#   name                 = "enable-winrm"
#   virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.10"

#   settings = <<SETTINGS
# {
#   "commandToExecute": "powershell -ExecutionPolicy Unrestricted -Command \"winrm quickconfig -q; winrm set winrm/config/winrs @{MaxMemoryPerShellMB='512'}; winrm set winrm/config @{MaxTimeoutms='1800000'}; winrm set winrm/config/service @{AllowUnencrypted='true'}; winrm set winrm/config/service/auth @{Basic='true'}; Set-Item -Path WSMan:\\\\localhost\\\\Service\\\\AllowUnencrypted -Value `$true; Enable-PSRemoting -Force; New-NetFirewallRule -DisplayName 'Allow WinRM' -Direction Inbound -LocalPort 5985 -Protocol TCP -Action Allow\""
# }
# SETTINGS

#   depends_on = [azurerm_windows_virtual_machine.vm]
# }

data "azurerm_virtual_network" "existing_vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "existing_subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = var.vnet_resource_group_name
}

# resource "azurerm_public_ip" "public_ip" {
#   name                = "${var.vm_name}-public-ip"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Dynamic"
#   sku                 = "Basic"
# }

resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# resource "azurerm_network_interface" "nic" {
#   name                = var.nic_name
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = data.azurerm_subnet.existing_subnet.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.public_ip.id
#   }
# }


resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
  name                       = "Allow-RDP"
  priority                   = 1001
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "3389"
  source_address_prefix = "163.116.213.61"
  destination_address_prefix = "*"
}
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id

  depends_on = [
    azurerm_network_interface.nic,
    azurerm_network_security_group.nsg
  ]
}

# resource "azurerm_linux_virtual_machine" "vm" {
#   name                  = var.vm_name
#   resource_group_name   = var.resource_group_name
#   location              = var.location
#   size                  = var.vm_size
#   admin_username        = var.admin_username
#   admin_password        = var.admin_password
#   disable_password_authentication = false
#   network_interface_ids = [azurerm_network_interface.nic.id]
#   provision_vm_agent    = true

#   os_disk {
#     name                 = "${var.vm_name}-osdisk"
#     caching              = "ReadWrite"
#     storage_account_type = var.os_disk_type
#     disk_size_gb         = var.os_disk_size
#   }

#   source_image_reference {
#   publisher = "Canonical"
#   offer     = "0001-com-ubuntu-server-jammy"
#   sku       = "22_04-lts-gen2"
#   version   = "latest"
# }

resource "azurerm_windows_virtual_machine" "vm" {
  name                  = var.vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic.id]
  provision_vm_agent    = true

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size
  }

  source_image_reference {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2022-datacenter-g2"
  version   = "latest"
}

}
