variable "allowed_ingress_cidrs" {
  type = list(string)
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "onam_fix_demo" {
  name        = "onam-fix-demo"
  description = "Onam fix-PR demo (not attached to anything)"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from allowed IPs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ingress_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "onam-fix-demo"
    git_repo = "onamsecurity/onam-fix-demo"
    git_file = "terraform/security_group.tf"
  }
}
