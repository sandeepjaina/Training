resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.v_pcid


  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group_rule" "sg_ingress" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.allow_tls.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "sg_egress" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.allow_tls.id
  to_port           = 0
  type              = "egress"
  cidr_blocks = ["0.0.0.0/0"]
}



output "sgid" {
  value = aws_security_group.allow_tls.id
}

variable "v_pcid" {}