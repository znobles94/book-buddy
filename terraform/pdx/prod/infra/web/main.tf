### This TF creates web instance resources

locals {
  default_tags = {
    Project     = "Book-Buddy"
    Environment = "Production"
  }

  tags = merge(local.default_tags, var.additional_tags)
}

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
  name = "book-buddy"
  // We can expand this further later
  availability_zones = ["us-west-2a"]
  max_size           = 1
  min_size           = 0
  desired_capacity   = 0
  launch_template {
    id      = aws_launch_template.book-buddy.id
    version = "$Latest"
  }
//  tags = local.tags
}

/*
resource "aws_lb" "book-buddy" {
  name                       = "book-buddy"
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = false

  access_logs {

  }
  tags = local.tags
}
*/
