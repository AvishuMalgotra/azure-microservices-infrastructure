infrastructure_map = {
  "dev-rg-01" = {
    location = "West US"
    tags     = { department = "engineering" }
    
    acr_config = {
      name = "devacr9911"
    }

    aks_config = {
      cluster_name = "dev-aks-cluster"
      dns_prefix   = "devaks"
      
      default_node_pool = {
        name       = "system"
        node_count = 1
        vm_size    = "Standard_B2s"
      }
    }
  }
}
