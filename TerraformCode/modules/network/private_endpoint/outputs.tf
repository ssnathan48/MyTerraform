output "private_ip" {
  value = var.enable ? azurerm_private_endpoint.pe[0].private_service_connection[0].private_ip_address : null
}
