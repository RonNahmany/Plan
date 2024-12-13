region = "il-central-1"
machine_list = [
  {
    ami           = "ami-0d0e33c53ae589b94"
    instance_type = "t3.micro"
    count         = "3"
    name          = "Global"
    inbound_rule  = [
      {
        port        = 80
        description = "HTTP traffic"
        protocol    = "tcp"
        cidr_block = "0.0.0.0/0"
      },
      {
        port        = 22
        description = "SSH traffic"
        protocol    = "tcp"
        cidr_block = "0.0.0.0/0"
      },
      {
        port        = 443
        description = "Https trafic"
        protocol    = "tcp"
        cidr_block = "0.0.0.0/0"
      }
    ]
    outbound_rule = [
      {
        port        = 0
        description = "Allow all outbound traffic"
        protocol    = "-1"
        cidr_block = "0.0.0.0/0"
      }
    ]
  }
]


tags = {
  Environment = "Production"
  Project     = "BankHAHAHA"
}







