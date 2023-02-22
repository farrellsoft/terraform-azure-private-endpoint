
module "resource-naming" {
  source  = "app.terraform.io/Farrellsoft/resource-naming/azure"
  version = "1.0.1"
  
  application         = var.application
  environment         = var.environment
  instance_number     = var.instance_number
  resource_type       = var.resource_type
}

resource azurerm_private_endpoint this {
  name                = module.resource-naming.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  dynamic "private_service_connection" {
    for_each = var.private_connections
    iterator = connection
    
    content {
      name                           = connection.key
      is_manual_connection           = false
      private_connection_resource_id = connection.value.resource_id
      subresource_names              = connection.value.subresource_names
    }
  }
}

resource azurerm_private_dns_a_record this {
  count            = length(var.private_connections)

  name                = reverse(split("/", local.private_connections[count.index].value.resource_id))[0]
  zone_name           = reverse(split("/", local.private_connections[count.index].value.private_dns_zone_id))[0]
  resource_group_name = split("/", local.private_connections[count.index].value.private_dns_zone_id)[4]
  ttl                 = 300
  records             = [ azurerm_private_endpoint.this.private_service_connection[count.index].private_ip_address ]
}