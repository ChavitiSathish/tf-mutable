resource "null_resource" "apply" {
  triggers = {
    APP_VERSION = var.APP_VERSION
    STRING  = local.STRING
    // To trigger this all the time then use the following way
    //APP_VERSION = timestamp()
  }
  count                         = local.DEPLOY_COUNT
  provisioner "remote-exec" {
    connection {
      host                      = element(local.DEPLOY_HOSTS, count.index)
      user                      = "centos"
      password                  = "DevOps321"
    }

    inline = [
      "ansible-pull -i localhost, -U https://DevOps-Batches@dev.azure.com/DevOps-Batches/DevOps57/_git/ansible roboshop-pull.yml -e COMPONENT=${var.COMPONENT} -e ENV=${var.ENV} -e APP_PORT=80 -e APP_VERSION=${var.APP_VERSION}"
    ]

  }
}

locals {
  DEPLOY_COUNT    = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT
  DEPLOY_HOSTS    = concat(aws_instance.od-instance.*.private_ip, aws_spot_instance_request.instances.*.private_ip)
  STRING = join(",", concat(aws_instance.od-instance.*.private_ip, aws_spot_instance_request.instances.*.private_ip))
}

