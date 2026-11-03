# Onam fix-PR demo: a security group deliberately open to the internet, attached to nothing.
# Onam links the live group to this file through its git_repo / git_file tags and can open a
# pull request that narrows the rule. Nothing here is deployed by CI; the group was created by hand.

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "onam_fix_demo" {
  name        = "onam-fix-demo"
  description = "Onam fix-PR demo (not attached to anything)"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from anywhere (deliberately wrong for the demo)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
