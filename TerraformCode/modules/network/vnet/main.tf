resource "azurerm_virtual_network" "vnet" {
  count               = var.enable ? 1 : 0
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "gateway_subnet" {
  count                = var.enable ? 1 : 0
  name                 = var.gateway_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes     = [var.gateway_subnet_cidr]
}

resource "azurerm_subnet" "private_endpoint_subnet" {
  count                = var.enable ? 1 : 0
  name                 = var.private_endpoint_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes     = [var.private_endpoint_subnet_cidr]
}
