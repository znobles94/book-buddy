variable "additional_tags" {
  type        = map(string)
  description = "More tags to be added to web infra resources"
  default     = {}
}
