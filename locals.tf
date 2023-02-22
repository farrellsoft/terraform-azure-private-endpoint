locals {
  private_connections = [ for k,v in var.private_connections : {
    name = k
    value = v
  } ]
}