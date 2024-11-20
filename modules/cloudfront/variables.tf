variable "distribution_id" {
  description = "Identifier for the CloudFront distribution"
  type        = string
}

variable "origins" {
  description = "List of origin domains"
  type        = list(string)
}

variable "acm_certificate" {
  description = "ACM certificate ARN"
  type        = string
}

variable "aliases" {
  description = "List of alias domains"
  type        = list(string)
}