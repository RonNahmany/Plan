output "SSH_access" {
    value = tls_private_key.Instance_key.private_key_pem
}
output "instance_ip" {
  value = [for instance in aws_instance.ec2 : instance.public_dns]
}

