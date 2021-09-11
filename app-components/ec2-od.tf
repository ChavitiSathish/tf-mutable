resource "aws_instance" "od-instance" {
  count                  = var.OD_INSTANCE_COUNT
  ami                    = data.aws_ami.ami.id
  instance_type          = var.INSTANCE_TYPE
  vpc_security_group_ids = [aws_security_group.allow_component.id]
  subnet_id              = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS,count.index)

  tags                   = {
    Name                 = "${var.COMPONENT}-${var.ENV}-od"
  }
}

