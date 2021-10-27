resource "aws_spot_instance_request" "roboshop" {
  count = local.LENGTH
  spot_price    = "0.031"
  ami = "ami-0e4e4b2f188e91845"
  instance_type = "t2.micro"
  wait_for_fulfillment = true
 # security_groups = ["sg-e9533ef3"]
  vpc_security_group_ids = ["sg-e9533ef3"]
  tags = {
    Name = element(var.components, count.index)
  }

}
#resource "aws_security_group_rule" "SG_ingress" {
#  from_port         = 0
#  protocol          = "-1"
#  security_group_id = "sg-e9533ef3"
#  to_port           = 0
#  type              = "ingress"
#}




resource "aws_ec2_tag" "tagname" {
  count = local.LENGTH
  key         = "Name"
  resource_id = element(aws_spot_instance_request.roboshop.*.spot_instance_id, count.index)
  value       = element(var.components, count.index)
}


resource "null_resource" "provisioning" {
  depends_on = [aws_route53_record.route]
  count = length(var.components)

  provisioner "remote-exec" {
    connection {
      host = element(aws_spot_instance_request.roboshop.*.public_ip, count.index)
      user = "centos"
      password = "DevOps321"
    }
    inline = [
      "cd /home/centos/",
      "git clone https://github.com/sandeepjaina/terraform.git",
      #"sudo mv shell-scripting/ shell-scripting_repo",
      "sudo cd terraform/roboshop/roboshop",
      "sudo set-hostname ${element(var.components, count.index)}",
      "sudo make ${element(var.components, count.index)}"
    ]

  }
}

resource "aws_route53_record" "route" {
  count = local.LENGTH
  name    = element(var.components,count.index )
  type    = "A"
  zone_id = "Z05637993UP3Q4ZPSETFE"
  ttl = 300
  records = [element(aws_spot_instance_request.roboshop.*.private_ip, count.index)]
}

output "securitygroups" {
  value = aws_spot_instance_request.roboshop.*.security_groups
}


locals {
  LENGTH    = length(var.components)
}

variable "components" {}