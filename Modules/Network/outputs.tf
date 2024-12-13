output "subnet_ids" {
  value = { for key, subnet in aws_subnet.Tf_subnet : key => subnet.id }
}

output "vpc_id" {
  value = aws_vpc.tf_vpc.id
}
