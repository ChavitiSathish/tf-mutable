resource "aws_route53_record" "dns" {
  count                       = var.BACKEND ? 1 : 0
  zone_id                     = data.terraform_remote_state.vpc.outputs.INTERNAL_DNS_ZONE_ID
  name                        = "${var.COMPONENT}-${var.ENV}.roboshop.internal"
  type                        = "CNAME"
  ttl                         = "300"
  records                     = [data.terraform_remote_state.alb.outputs.PRIVATE_LB_DNS]
}
