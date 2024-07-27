### This TF creates web instance resources

/*
data "aws_ami" "ubuntu" {
// ami-05e06910b85180aeb
// custom made ami later
}
*/

resource "aws_launch_template" "book-buddy" {
  name_prefix = "book-buddy"
  // AWS free-tier monthly usage allowance
  instance_type = "t2.micro"
  image_id      = "ami-09a13b25443518b29"
  tags          = local.tags
}

resource "aws_autoscaling_group" "book-buddy" {
  name                = "book-buddy"
  max_size            = 1
  min_size            = 0
  desired_capacity    = 0
  vpc_zone_identifier = data.aws_subnets.default.ids
  launch_template {
    id      = aws_launch_template.book-buddy.id
    version = "$Latest"
  }
  tag {
    key                 = "Project"
    value               = var.project
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
}

resource "aws_lb" "book-buddy" {
  name                       = "book-buddy"
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
