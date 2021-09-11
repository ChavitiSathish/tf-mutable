resource "null_resource" "apply" {
  count                         = local.DEPLOY_COUNT
  provisioner "remote-exec" {
    connection {
      host                      = element(local.DEPLOY_HOSTS, count.index)
      user                      = "centos"
      password                  = "DevOps321"
    }

    inline = [
      "sudo yum install python3-pip -y",
      "sudo pip3 install pip --upgrade",
      "sudo pip3 install ansible==4.1.0",
      "ansible-pull -i localhost, -U https://github.com/ChavitiSathish/ansible.git roboshop-pull.yml -e COMPONENT=${var.COMPONENT} -e ENV=${var.ENV}"
    ]

  }
}

locals {
  DEPLOY_COUNT    = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT
  DEPLOY_HOSTS    = concat(aws_instance.od-instance.*.private_ip, aws_spot_instance_request.instances.*.private_ip)
}

