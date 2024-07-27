variable "additional_tags" {
  type        = map(string)
  description = "More tags to be added to web infra resources"
  default     = {}
}

variable "deletion_protection" {
  type        = bool
  description = "Should ALBs have deletion protection? (bool)"
  default     = false
}
