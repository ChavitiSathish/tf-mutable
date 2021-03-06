data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "chtfbucket"
    key = "mutable/vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

  data "terraform_remote_state" "alb" {
    backend             = "s3"
    config              = {
      bucket            = "chtfbucket"
      key               = "mutable/alb/${var.ENV}/terraform.tfstate"
      region            = "us-east-1"
    }
  }

data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "^Centos*"
  owners           = ["973714476881"]
}
