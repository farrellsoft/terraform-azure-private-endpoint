
variable application {
  type = string
  validation {
    condition     = length(var.application) > 3
    error_message = "${var.application} must be a minimum of three (3) characters."
  }
}

variable environment {
  type = string
  validation {
    condition     = length(var.environment) == 3
    error_message = "${var.environment} must be three (3) characters."
  }
}

variable instance_number {
  type = string
  validation {
    condition     = can(regex("^[0-9]{3}$", var.instance_number))
    error_message = "${var.instance_number} must be three (3) numbers."
  }
  default   = "001"
}

variable location {
  type        = string
  description = "The location where the resources will be created."
}

variable resource_group_name {
  type        = string
  description = "The name of the resource group in which to create the resources."
}

variable subnet_id {
  type        = string
  description = "The ID of the subnet in which to create the resources."
}

variable resource_type {
  type        = string
  description = "The type of resource to create."
}

variable private_connections {
  type              = map(object({
    resource_id         = string  
    subresource_names   = list(string)
    private_dns_zone_id = string
  }))
  description       = "A map of private connections to create."
  default           = {}
}