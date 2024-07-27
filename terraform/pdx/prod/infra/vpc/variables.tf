variable "additional_tags" {
  type        = map(string)
  description = "Additional tags for the VPC resources"
  default     = {}
}
variable "environment" {
  type        = string
  default     = "Nonproduction"
  description = "Environment that VPC / subnet / routing resources will be built for"
}
