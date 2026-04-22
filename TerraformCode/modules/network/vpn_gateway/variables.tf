variable "enable" {
  type = bool
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "gateway_subnet_id" {
  type = string
}

variable "vpn_gateway_sku" {
  type = string
}

variable "vpn_public_ip_name" {
  type = string
}
variable "root_cert_data" {
  type = string
}
variable "client_ip_cidr" {
  type    = string
  default = "172.16.201.0/24"
}
variable "gateway_name" {
  type    = string
}