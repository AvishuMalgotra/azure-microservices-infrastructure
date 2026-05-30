module "resource_groups" {
  source   = "../../modules/resource_group"
  for_each = var.infrastructure_map

  name     = each.key
  location = each.value.location
  tags     = merge(each.value.tags, { environment = "prod" })
}

module "acr" {
  source   = "../../modules/acr"
  for_each = { for k, v in var.infrastructure_map : k => v.acr_config if v.acr_config != null }

  name                = each.value.name
  resource_group_name = module.resource_groups[each.key].name
  location            = module.resource_groups[each.key].location
  sku                 = "Premium"
  admin_enabled       = each.value.admin_enabled
  georeplications     = each.value.georeplications
  tags                = merge(var.infrastructure_map[each.key].tags, { environment = "prod" })
}

module "aks" {
  source   = "../../modules/aks"
  for_each = { for k, v in var.infrastructure_map : k => v.aks_config if v.aks_config != null }

  cluster_name          = each.value.cluster_name
  resource_group_name   = module.resource_groups[each.key].name
  location              = module.resource_groups[each.key].location
  dns_prefix            = each.value.dns_prefix
  kubernetes_version    = each.value.kubernetes_version
  sku_tier              = "Standard"
  default_node_pool     = each.value.default_node_pool
  additional_node_pools = each.value.additional_node_pools
  network_profile       = each.value.network_profile
  tags                  = merge(var.infrastructure_map[each.key].tags, { environment = "prod" })
}
