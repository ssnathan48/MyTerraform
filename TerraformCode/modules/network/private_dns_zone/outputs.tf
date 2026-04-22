output "dns_zone_name" {
  value = var.enable ? azurerm_private_dns_zone.zone[0].name : null
}
