
provider azurerm {
  features {}
}

module "resource-naming" {
  source  = "app.terraform.io/Farrellsoft/resource-naming/azure"
  version = "0.0.11"
  
  application         = var.application
  environment         = var.environment
  instance_number     = var.instance_number
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