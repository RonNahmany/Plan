resource "aws_security_group" "SG" {
  for_each = { for machine in var.machine_list : machine.name => machine }
  vpc_id = var.vpc_id
  name   = "${each.key}_${var.tags.Project}_SG"
  tags = merge(
    var.tags,
    { Name = "${var.tags.Project}_${each.key}_SG" }
  )

  dynamic "egress" {
    for_each = each.value.outbound_rule
    content {
      to_port     = egress.value.port
      from_port   = egress.value.port
      protocol    = egress.value.protocol
      description = egress.value.description
      cidr_blocks = [egress.value.cidr_block]
    }
  }

  dynamic "ingress" {
    for_each = each.value.inbound_rule
    content {
      to_port     = ingress.value.port
      from_port   = ingress.value.port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = [ingress.value.cidr_block]
    }
  }
}


resource "tls_private_key" "Instance_key" {
    algorithm   = "RSA"
    rsa_bits    = 2048
  
}

resource "aws_key_pair" "keypair" {
    depends_on      = [ tls_private_key.Instance_key ]
    key_name        = "${var.tags.Project}_KeyPair"
    public_key      = tls_private_key.Instance_key.public_key_openssh

}

resource "aws_instance" "ec2" {
  for_each = var.machine_list

  instance_type          = var.machine_list[count.index].instance_type
  ami                    = var.machine_list[count.index].ami
  vpc_security_group_ids = [aws_security_group.SG[var.machine_list[count.index].name].id]
  subnet_id              = var.subnet_id[var.machine_list[count.index].name]

  tags = merge(
    var.tags,
    { Name = "${var.tags.Project}_${var.machine_list[count.index].name}_${count.index}" }
  )
}



