variable "enable" {
  type = bool
}

variable "vnet_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vnet_address_space" {
  type = string
}

variable "gateway_subnet_cidr" {
  type = string
}
variable "private_endpoint_subnet_cidr" {
  type = string
}
variable "private_endpoint_subnet_name" {
  type = string
}
variable "gateway_subnet_name" {
  type = string
}