variable "enable" {
  type = bool
}

variable "pe_name" {
  type = string
}

variable "resource_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subresource_names" {
  type    = list(string)
  default = ["account"]
}
variable "private_endpoint_subnet_name" {
  type = string
  default="private-endpoint-subnet"
}
