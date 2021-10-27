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

#
#resource "null_resource" "provisioning" {
#  depends_on = [aws_route53_record.route]
#  count = length(var.components)
#
#  provisioner "remote-exec" {
#    connection {
#      host = element(aws_spot_instance_request.roboshop.*.public_ip, count.index)
#      user = "centos"
#      password = "DevOps321"
#    }
#    inline = [
#      "cd /home/centos/",
#      "git clone https://github.com/sandeepjaina/terraform.git",
#      #"sudo mv shell-scripting/ shell-scripting_repo",
#      "sudo cd terraform/roboshop/roboshop",
#      "sudo set-hostname ${element(var.components, count.index)}",
#      "sudo make ${element(var.components, count.index)}"
#    ]
#
#  }
#}

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

#components = ["cart" 0, "catalogue" 1, "frontend"2, "mongodb"3, "mysql"4, "payments"5, "rabbitmq"6, "redis"7, "shipping"8, "user"9]

resource "local_file" "inventory-file" {
 content     = "[FRONTEND]\n${aws_instance.instances.*.private_ip[2]}\n[PAYMENT]\n${aws_instance.instances.*.private_ip[5]}\n[SHIPPING]\n${aws_instance.instances.*.private_ip[8]}\n[USER]\n${aws_instance.instances.*.private_ip[9]}\n[CATALOGUE]\n${aws_instance.instances.*.private_ip[1]}\n[CART]\n${aws_instance.instances.*.private_ip[0]}\n[REDIS]\n${aws_instance.instances.*.private_ip[7]}\n[RABBITMQ]\n${aws_instance.instances.*.private_ip[6]}\n[MONGODB]\n${aws_instance.instances.*.private_ip[3]}\n[MYSQL]\n${aws_instance.instances.*.private_ip[4]}\n"
 filename    = "/tmp/inv-roboshop-${var.ENV}"
}
locals {
  LENGTH    = length(var.components)
}

variable "components" {}