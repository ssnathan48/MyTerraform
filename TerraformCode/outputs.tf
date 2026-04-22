output "vnet_id" {
  value       = module.vnet.vnet_id
  description = "VNet ID (when private access enabled)."
}

output "private_endpoint_ip" {
  value       = module.private_endpoint.private_ip
  description = "Private IP of AI Foundry Private Endpoint."
}

output "vpn_gateway_public_ip" {
  value       = module.vpn_gateway.public_ip
  description = "Public IP of VPN gateway."
}

#--------------------------------------------
# Outputs the Endpoint to your terminal after deployment
output "ai_resource_endpoint" {
  value = azurerm_cognitive_account.ai_resource.endpoint
}
output "ai_resource_primary_key" {
  value     = azurerm_cognitive_account.ai_resource.primary_access_key
  sensitive = true
}