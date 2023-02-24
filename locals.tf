locals {
  private_connections = [ for k,v in var.private_connections : {
    name = k
    value = v
  } ]

  private_endpoint_resource_group_name = var.resource_group_name != null ? var.resource_group_name : split("/", var.subnet_id)[4]
}