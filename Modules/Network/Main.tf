data "aws_availability_zones" "available" {}

resource "aws_vpc" "tf_vpc" {
    cidr_block              = var.cidr_block["Subnet"]
    enable_dns_hostnames    = var.network_config.dns_hostname
    enable_dns_support      = var.network_config.dns_support
    tags = var.tags
}
resource "aws_subnet" "Tf_subnet" {
    for_each                = { for key, value in var.cidr_block : key => value if key != "Subnet" }
    vpc_id                  = aws_vpc.tf_vpc.id
    cidr_block              = each.value
    map_public_ip_on_launch = true
    availability_zone       = data.aws_availability_zones.available.names[0]
    tags = merge(
        var.tags,
        {Name = "${var.tags.Project}_${each.key}"}
    )
}
resource "aws_internet_gateway" "tf_IG" {
    vpc_id      = aws_vpc.tf_vpc.id
    tags = var.tags
}
resource "aws_route_table" "tf_rt" {
    vpc_id          = aws_vpc.tf_vpc.id
    route{
        cidr_block  = "0.0.0.0/0"
        gateway_id  = aws_internet_gateway.tf_IG.id
    }
    tags = var.tags

}
resource "aws_route_table_association" "tf_rta" {
    for_each = aws_subnet.Tf_subnet
    subnet_id       = each.value.id
    route_table_id  = aws_route_table.tf_rt.id
}

