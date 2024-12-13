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

variable "cidr_block" {
  type = map(string)
}
variable "tags" {
    type = map(string)
}

