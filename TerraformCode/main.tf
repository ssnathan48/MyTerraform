#----------------------------------------------------------
# 1. Create the Resource Group
locals {
  base = "${var.org_code}-${var.app_code}-${var.environment}-${var.region_code}"
}

module "rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${local.base}-rg"
  location            = var.location
}
# 1.1 The Azure foundry or openai Account (The Service)
resource "azurerm_cognitive_account" "ai_resource" {
  name                = "${local.base}-svc"
  location            = var.location
  resource_group_name = module.rg.name
  # Conditional Kind: "AIServices" for Foundry, "OpenAI" for standard
  kind     = var.use_ai_foundry ? "AIServices" : "OpenAI"
  sku_name = "S0"
  # REQUIRED for AI Foundry Projects
  # If true, it enables management; if false, it sets to null (standard OpenAI behavior)
  project_management_enabled = var.use_ai_foundry ? true : false

  # A custom subdomain is mandatory when project_management_enabled is true
  custom_subdomain_name = var.use_ai_foundry ? "${local.base}-svc" : null

  identity {
    type = "SystemAssigned"
  }
}
#---------------------------------------------------------
# 2. Network components
module "vnet" {
  source                       = "./modules/network/vnet"
  enable                       = var.use_private_access
  vnet_name                    = "${local.base}-vnet"
  vnet_address_space           = var.vnet_address_space
  gateway_subnet_cidr          = var.gateway_subnet_cidr
  gateway_subnet_name          = "GatewaySubnet"
  private_endpoint_subnet_name = "${local.base}-pesubnet"
  private_endpoint_subnet_cidr = var.private_endpoint_subnet_cidr
  location                     = module.rg.location
  resource_group_name          = module.rg.name
}

module "private_endpoint" {
  source              = "./modules/network/private_endpoint"
  enable              = var.use_private_access
  pe_name             = "${local.base}-pe"
  resource_id         = azurerm_cognitive_account.ai_resource.id
  subnet_id           = module.vnet.private_endpoint_subnet_id
  location            = module.rg.location
  resource_group_name = module.rg.name
}

module "vpn_gateway" {
  source              = "./modules/network/vpn_gateway"
  enable              = var.use_private_access
  location            = module.rg.location
  resource_group_name = module.rg.name
  gateway_name        = "${local.base}-vgw"
  vnet_id             = module.vnet.vnet_id
  gateway_subnet_id   = module.vnet.gateway_subnet_id
  vpn_gateway_sku     = var.vpn_gateway_sku
  vpn_public_ip_name  = "${local.base}-pip"
  root_cert_data      = var.root_cert_data
}
module "private_dns_zone" {
  source              = "./modules/network/private_dns_zone"
  enable              = var.use_private_access
  resource_group_name = module.rg.name
  location            = module.rg.location
  vnet_id             = module.vnet.vnet_id
  dns_zone_name       = "privatelink.cognitiveservices.azure.com"
  ai_account_name     = azurerm_cognitive_account.ai_resource.name
}

#----------------------------------------------
#2.1 If using AI Foundry, we need to create a Project to host the deployment
resource "azurerm_cognitive_account_project" "project" {
  count                = var.use_ai_foundry ? 1 : 0
  name                 = "${local.base}-prj"
  cognitive_account_id = azurerm_cognitive_account.ai_resource.id
  location             = module.rg.location
  identity {
    type = "SystemAssigned"
  }
}

#-----------------------------------------------------
# 2.2. The specific Model Deployment (The "Brain")
resource "azurerm_cognitive_deployment" "gpt4o_mini" {
  name                 = var.deployment_name
  cognitive_account_id = azurerm_cognitive_account.ai_resource.id

  model {
    format  = "OpenAI"
    name    = "gpt-4o-mini"
    version = "2024-07-18"
  }

  sku {
    name = "GlobalStandard"
  }
  depends_on = [azurerm_cognitive_account.ai_resource]
}
