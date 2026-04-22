variable "enable" { type = bool }

variable "resource_group_name" { type = string }
variable "location" { type = string }

variable "vnet_id" { type = string }

variable "dns_zone_name" {
  type    = string
  default = "privatelink.cognitiveservices.azure.com"
}
variable "ai_account_name" {
  type = string
}
