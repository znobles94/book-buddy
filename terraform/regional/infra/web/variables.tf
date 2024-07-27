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

variable "desired_capacity" {
  type        = number
  description = "Number of instances we'd like running"
  default     = 1
}

variable "environment" {
  type        = string
  description = "Environment for web application resources"
  default     = "nonprod"
}

variable "max_size" {
  type        = number
  description = "Maximum acceptable capacity"
  default     = 9
}

variable "min_size" {
  type        = number
  description = "Minimum acceptable capacity"
  default     = 0
}

variable "project" {
  type        = string
  description = "Project of the created web resources"
  default     = "Book-Buddy"
}
