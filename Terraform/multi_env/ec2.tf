resource "aws_instance" "foo" {
  ami           = "ami-0e4e4b2f188e91845" # us-west-2
  instance_type = "t2.micro"
  tags          = {
    Name = "SampleVM-${var.ENV}"
  }
}

variable "ENV" {}