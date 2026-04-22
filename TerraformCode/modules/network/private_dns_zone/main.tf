resource "azurerm_private_dns_zone" "zone" {
  count               = var.enable ? 1 : 0
  name                = var.dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  count                 = var.enable ? 1 : 0
  name                  = "link-${var.ai_account_name}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.zone[0].name
  virtual_network_id    = var.vnet_id
  registration_enabled  = false
}

resource "azurerm_private_dns_a_record" "ai_acct_rec" {
  count               = var.enable ? 1 : 0
  name                = var.ai_account_name
  zone_name           = azurerm_private_dns_zone.zone[0].name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [] # optional: can be left empty; PE will populate
}
