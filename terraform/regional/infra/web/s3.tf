resource "aws_s3_bucket" "lb-logs" {
  bucket = "${var.project}-${var.environment}-lb-logs"
  tags   = local.tags
}
