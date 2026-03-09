terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "2.4.0"
    }
  }
}

provider "nutanix" {
  username     = var.user
  password     = var.password
  endpoint     = var.endpoint
  insecure     = true
  wait_timeout = 60
}

resource "nutanix_object_store_v2" "obj3"{
  name                     = var.object_store_name
  description              = "Terraform create object store example"
  domain                   = var.domain_name
  num_worker_nodes         = 3
  cluster_ext_id           = var.cluster_uuid
  total_capacity_gib       = 100
  public_network_reference = var.public_network_reference
#  state                    = "UNDEPLOYED_OBJECT_STORE"
  dynamic "public_network_ips" {
    for_each = var.public_network_ip

    content {
      ipv4 {
        value = public_network_ips.value
      }
    }
  }
  storage_network_reference = var.storage_network_reference
  storage_network_dns_ip {
    ipv4 {
      value = var.storage_network_dns_ip
    }
  }
  storage_network_vip {
    ipv4 {
      value = var.storage_network_vip
    }
  }
}
