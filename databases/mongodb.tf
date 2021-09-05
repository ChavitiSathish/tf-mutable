resource "aws_instance" "mongodb" {
  ami                              =  data.aws_ami.ami.id
  instance_type                    = " "
}

#monogdb