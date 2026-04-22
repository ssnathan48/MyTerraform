resource "azurerm_public_ip" "vpn_pip" {
  count               = var.enable ? 1 : 0
  name                = var.vpn_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones = ["1", "2", "3"]
}

resource "azurerm_virtual_network_gateway" "vpn" {
  count               = var.enable ? 1 : 0
  name                = var.gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  ip_configuration {
    name                          = "vpngw-ipconfig"
    public_ip_address_id          = azurerm_public_ip.vpn_pip[0].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gateway_subnet_id
  }
  sku = var.vpn_gateway_sku
   vpn_client_configuration {
    address_space = [var.client_ip_cidr]

    root_certificate {
      name             = "SwamiRootCert"
      public_cert_data = var.root_cert_data
    }
  }
}

