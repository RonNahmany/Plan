output "DNS" {
    value = module.ec2_complete.instance_ip
}
output "SSH" {
    value = module.ec2_complete.SSH_access
    sensitive = true
}
