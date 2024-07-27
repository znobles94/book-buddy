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
  target_group_arns   = [aws_lb_target_group.app.arn]
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

resource "aws_autoscaling_policy" "scale-up" {
  name                   = "scale-up"
  scaling_adjustment     = 3
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.book-buddy.name
}

resource "aws_cloudwatch_metric_alarm" "cpu-up" {
  alarm_name          = "cpu-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "70"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.book-buddy.name
  }
  alarm_description = "Monitor for CPU spikes"
  alarm_actions     = [aws_autoscaling_policy.scale-up.arn]
}
