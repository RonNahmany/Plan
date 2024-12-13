provider "aws" {
  region = var.region
}

module "infra_networking" {
  source = "./Modules/Network"
  cidr_block =  var.cidr_block
  tags = var.tags
}

module "ec2_complete" {
    source          = "./Modules/Instance"
    depends_on      = [ module.infra_networking ]
    tags            = var.tags
    machine_list    = var.machine_list
    vpc_id          = module.infra_networking.vpc_id
    subnet_id      = module.infra_networking.subnet_ids
    
}
