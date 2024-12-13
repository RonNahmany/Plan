variable "region" {
    type = string
}
variable "network_config" {
    description     = "network configuration"
    type            = object({
      dns_support   = bool
      dns_hostname  = bool
    })
    default = {
      dns_support   = true
      dns_hostname  = true
    }
}
variable "machine_list" {
    type                = list(object({
      ami               = string
      instance_type     = string
      name              = string
      count             = number
      #subnet_id         = string
      count             = number
      inbound_rule = list(object({
        port = number
        description = string
        protocol = string
        cidr_block = string
      }))
      outbound_rule = list(object({
        port = number
        description = string
        protocol = string
        cidr_block = string
      }))
    }))
}
variable "cidr_block" {
  type = map(string)
}
variable "tags" {
    type = map(string)
}
