output "PUBLIC_LB_ARN" {
  value = aws_lb.public.arn
}

output "PRIVATE_LB_ARN" {
  value = aws_lb.private.arn
}

output "PRIVATE_LB_LISTENER_ARN" {
  value = aws_lb_listener.backend.arn
}

output "PUBLIC_LB_DNS" {
  value = aws_lb.public.dns_name
}

output "PRIVATE_LB_DNS" {
  value = aws_lb.private.dns_name
}
