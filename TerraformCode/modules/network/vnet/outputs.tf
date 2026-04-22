output "vnet_id" {
  value = var.enable ? azurerm_virtual_network.vnet[0].id : null
}

output "gateway_subnet_id" {
  value = var.enable ? azurerm_subnet.gateway_subnet[0].id : null
}

output "private_endpoint_subnet_id" {
  value =  var.enable ? azurerm_subnet.private_endpoint_subnet[0].id : null
}
