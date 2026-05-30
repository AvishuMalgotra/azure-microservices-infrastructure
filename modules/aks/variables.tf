variable "cluster_name" {
  type = string
}
variable "resource_group_name"{
  type = string
}
variable "location" {
  type = string
}
variable "dns_prefix" {
  type = string
}
variable "kubernetes_version" {
  type    = string
  default = null
}
variable "sku_tier" {
  type    = string
  default = "Free"
}
variable "tags" {
  type    = map(string)
  default = {}
}

variable "default_node_pool" {
  type = object({
    name                = string
    node_count          = number
    vm_size             = string
    vnet_subnet_id      = optional(string)
    enable_auto_scaling = optional(bool, false)
    min_count           = optional(number)
    max_count           = optional(number)
  })
}

variable "additional_node_pools" {
  type = map(object({
    vm_size             = string
    node_count          = optional(number, 1)
    vnet_subnet_id      = optional(string)
    enable_auto_scaling = optional(bool, false)
    min_count           = optional(number)
    max_count           = optional(number)
    node_labels         = optional(map(string))
    node_taints         = optional(list(string))
  }))
  default = {}
}

variable "network_profile" {
  type = object({
    network_plugin    = optional(string, "azure")
    load_balancer_sku = optional(string, "standard")
    network_policy    = optional(string)
  })
  default = null
}
