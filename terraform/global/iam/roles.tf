# Create roles for book-buddy
resource "aws_iam_role" "book-buddy" {
  name               = "book-buddy"
  path               = "/infra/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_instance_profile" "book-buddy" {
  name = "book-buddy-web"
  role = aws_iam_role.book-buddy.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}
