resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
    Environment = "dev"
    Application = "AWS Compliance"
    Creator     = "AWS Compliance"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 0
  to_port           = 21
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  //ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = aws_security_group.allow_tls.id
  description = "test"
}
