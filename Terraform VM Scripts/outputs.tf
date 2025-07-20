output "vm_name" {
  description = "The name of the virtual machine"
  value       = azurerm_windows_virtual_machine.vm.name
}

output "vm_private_ip" {
  description = "The private IP address of the VM"
  value       = azurerm_network_interface.nic.private_ip_address
}

output "resource_group" {
  description = "The name of the resource group"
  value       = var.resource_group_name
}
