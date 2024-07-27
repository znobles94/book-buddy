locals {
  environment = var.environment == "prod" ? "Production" : "Nonproduction"
  default_tags = {
    Project     = "Book-Buddy"
    Environment = "Production"
  }

  tags = merge(local.default_tags, var.additional_tags)
}
