infrastructure_map = {
  "prod-rg-01" = {
    location = "East US"
    tags     = { department = "finance" }
    
    acr_config = {
      name          = "prodacr9911"
      sku           = "Premium"
      admin_enabled = true
    }

    aks_config = {
      cluster_name       = "prod-aks-cluster"
      dns_prefix         = "prodaks"
      kubernetes_version = "1.27.3"
      
      default_node_pool = {
        name                = "system"
        node_count          = 3
        vm_size             = "Standard_DS2_v2"
        enable_auto_scaling = true
        min_count           = 3
        max_count           = 5
      }

      additional_node_pools = {
        "workload" = {
          vm_size    = "Standard_DS3_v2"
          node_count = 2
        }
      }
    }
  }
}
