data "aws_ami" "ami" {
  most_recent = true
  name_regex = "^Centos*"
  owners = ["973714476881"]
}

resource "aws_spot_instance_request" "mongodb" {
  ami                       = "ami-074df373d6bafa625"
  instance_type             = "t3.micro"
  vpc_security_group_ids    = ["sg-083a944fa2575b4b6"]
  wait_for_fulfillment      = true
  tags                      = {
    Name                    = "mongodb-${var.ENV}"
  }
}