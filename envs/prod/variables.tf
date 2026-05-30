variable "infrastructure_map" {
  description = "A nested map to define Resource Groups, AKS clusters, and ACRs"
  type = map(object({
    location = string
    tags     = optional(map(string), {})
    
    acr_config = optional(object({
      name          = string
      sku           = optional(string, "Standard")
      admin_enabled = optional(bool, false)
      georeplications = optional(list(object({
        location                = string
        zone_redundancy_enabled = optional(bool, true)
        tags                    = optional(map(string), {})
      })), [])
    }))

    aks_config = optional(object({
      cluster_name       = string
      dns_prefix         = string
      kubernetes_version = optional(string)
      sku_tier           = optional(string, "Free")
      
      default_node_pool = object({
        name                = string
        node_count          = number
        vm_size             = string
        vnet_subnet_id      = optional(string)
        enable_auto_scaling = optional(bool, false)
        min_count           = optional(number)
        max_count           = optional(number)
      })

      additional_node_pools = optional(map(object({
        vm_size             = string
        node_count          = optional(number, 1)
        vnet_subnet_id      = optional(string)
        enable_auto_scaling = optional(bool, false)
        min_count           = optional(number)
        max_count           = optional(number)
        node_labels         = optional(map(string))
        node_taints         = optional(list(string))
      })), {})

      network_profile = optional(object({
        network_plugin    = optional(string, "azure")
        load_balancer_sku = optional(string, "standard")
        network_policy    = optional(string)
      }))
    }))
  }))
}
