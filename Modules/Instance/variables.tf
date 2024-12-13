variable "machine_list" {
    type                = list(object({
      ami               = string
      instance_type     = string
      name              = string
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
variable "tags" {
    type = map(string)
}
variable "vpc_id" {
  type        = string
  description = "VPC ID for the instances and security groups"
}

variable "subnet_id" {
    type = map(string)
}
