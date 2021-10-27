module "vpc" {
  source = "./vpc"

}

module "sg" {
  depends_on = [module.vpc]
  source = "./sg"
  v_pcid = module.vpc.vpcid
}

module "ec" {
  depends_on = [module.sg]
  source = "./ec2"
  subnet = module.vpc.subnet
  sg_id = module.sg.sgid
  #instance_type = "t3.micro"
}

provider "aws" {
  region = "us-east-1"
}