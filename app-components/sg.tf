resource "aws_security_group" "allow_component" {
  name                        = "allow_${var.COMPONENT}_${var.ENV}"
  description                 = "allow_${var.COMPONENT}_${var.ENV}"
  vpc_id                      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress                       {
    description               = "SSH"
    from_port                 = 22
    to_port                   = 22
    protocol                  = "tcp"
    cidr_blocks               = [data.terraform_remote_state.vpc.outputs.VPC_PRIVATE_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }

  ingress                       {
    description               = "APPPORT"
    from_port                 = var.APP_PORT
    to_port                   = var.APP_PORT
    protocol                  = "tcp"
    cidr_blocks               = [data.terraform_remote_state.vpc.outputs.VPC_PRIVATE_CIDR]
  }

  ingress                       {
    description               = "PROMETHEUS"
    from_port                 = 9100
    to_port                   = 9100
    protocol                  = "tcp"
    cidr_blocks               = [data.terraform_remote_state.vpc.outputs.VPC_PRIVATE_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }

  egress                        {
    from_port                 = 0
    to_port                   = 0
    protocol                  = "-1"
    cidr_blocks               = ["0.0.0.0/0"]
  }

  tags                          = {
    Name                        = "allow_${var.COMPONENT}_${var.ENV}"
    Environment                 = var.ENV
  }
}
