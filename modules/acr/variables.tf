variable "name" {
  type = string
}
variable "resource_group_name"{
  type = string
}
variable "location" {
  type = string
}
variable "sku" {
  type    = string
  default = "Standard"
}
variable "admin_enabled" {
  type    = bool
  default = false
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "georeplications" {
  type = list(object({
    location                = string
    zone_redundancy_enabled = optional(bool, true)
    tags                    = optional(map(string), {})
  }))
  default = []
}
