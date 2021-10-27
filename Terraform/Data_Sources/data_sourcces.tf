data "aws_ami" "ami_name" {
  owners = [973714476881]
  most_recent = true
  name_regex       = "^Centos"
}

output "sa" {
  value = data.aws_ami.ami_name.id
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ec2_spot_price" "example" {
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"

  filter {
    name   = "product-description"
    values = ["Linux/UNIX"]
  }
}

output "spot_price" {
  value = data.aws_ec2_spot_price.example.spot_price
}
