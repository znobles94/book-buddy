resource "aws_lb" "book-buddy" {
  name                       = "${var.project}-${var.environment}-alb"
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = var.deletion_protection == true ? true : false
  security_groups            = [aws_security_group.lb.id]
  subnets                    = data.aws_subnets.default.ids

  access_logs {
    bucket  = aws_s3_bucket.lb-logs.id
    enabled = true
  }
  tags       = local.tags
  depends_on = [aws_s3_bucket_policy.lb-policy]
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.book-buddy.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_lb_target_group" "app" {
  name     = "app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}
