output "public_ip" {
  value = var.enable ? azurerm_public_ip.vpn_pip[0].ip_address : null
}
