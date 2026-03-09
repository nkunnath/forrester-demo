variable "cluster_name" {
  type = string
}

variable "password" {
  type      = string
}
variable "endpoint" {
  type = string
}
variable "user" {
  type = string
}

variable "object_store_name" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "cluster_uuid" {
  type = string
}

variable "public_network_reference" {
  type = string
}

variable "storage_network_reference" {
  type = string
}

variable "public_network_ip" {
  type = list(string)
}

variable "storage_network_dns_ip" {
  type = string
}

variable "storage_network_vip" {
  type = string
}

