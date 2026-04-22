variable "org_code" {
  type        = string
  description = "your organization code"
}
variable "app_code" {
  type        = string
  description = "your application name"
}
variable "environment" {
  type        = string
  description = "your 3 letter environment"
}
variable "region_code" {
  type        = string
  description = "your 3 letter region code"
}
variable "tenant_id" {
  type        = string
  description = "The Azure tenant ID"
}
variable "subscription_id" {
  type        = string
  description = "The Azure Subscription ID"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Azure region (ensure it supports gpt-4o-mini)"
}

variable "deployment_name" {
  type        = string
  default     = "gpt-4o-mini-deployment"
  description = "The name you will use in your Python code"
}
variable "use_ai_foundry" {
  type        = bool
  default     = true
  description = "Set to true for Azure AI Foundry (AIServices), false for standalone OpenAI."
}
variable "use_private_access" {
  type    = bool
  default = false
}
variable "vnet_name" {
  type    = string
  default = "ai-vnet"
}
variable "vnet_address_space" {
  type    = string
  default = "10.0.0.0/16"
}
variable "gateway_subnet_cidr" {
  type    = string
  default = "10.0.0.0/27"
}
variable "private_endpoint_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}
variable "client_ip_cidr" {
  type    = string
  default = "172.16.201.0/24"
}
variable "vpn_gateway_sku" {
  type    = string
  default = "VpnGw1"
}
variable "vpn_public_ip_name" {
  type    = string
  default = "pip-vpngw-multi-ai"
}
variable "ai_account_pe_name" {
  type    = string
  default = "multi-agent-ai-service-pe"
}
variable "root_cert_data" {
  description = "Base64-encoded public cert data for P2S root certificate (no BEGIN/END lines)."
  type        = string
}
