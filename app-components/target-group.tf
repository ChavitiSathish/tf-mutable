resource "aws_lb_target_group" "target-group" {
  name                = "${var.COMPONENT}-${var.ENV}-tg"
  port                = 80
  protocol            = "HTTP"
  vpc_id              = data.terraform_remote_state.vpc.outputs.VPC_ID
  health_check        {
    enabled               = true
    path                  = "/health"
    healthy_threshold     = 2
    unhealthy_threshold   = 2
    timeout               = 2
    interval              = 5
  }
}

resource "aws_lb_target_group_attachment" "targets" {
  count               = local.TARGETS_COUNT
  target_group_arn    = aws_lb_target_group.target-group.arn
  target_id           = element(local.TARGETS, count.index )
  port                = var.APP_PORT
}

locals {
  TARGETS_COUNT       = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT
  TARGETS             = concat(aws_instance.od-instance.*.id, aws_spot_instance_request.instances.*.spot_instance_id)
}

resource "aws_lb_listener_rule" "rule" {
  count               = var.BACKEND ? 1 : 0
  listener_arn        = data.terraform_remote_state.alb.outputs.PRIVATE_LB_LISTENER_ARN
  priority            = var.LB_RULE_PRIORITY

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }

  condition {
    host_header {
      values        = ["${var.COMPONENT}-${var.ENV}.roboshop.internal"]
    }
  }
}

resource "aws_lb_listener" "frontend" {
  count                                 = var.BACKEND ? 0 : 1
  load_balancer_arn                     = data.terraform_remote_state.alb.outputs.PUBLIC_LB_ARN
  port                                  = "80"
  protocol                              = "HTTP"

  default_action {
    type                                = "forward"
    target_group_arn                    = aws_lb_target_group.target-group.arn
  }
}
