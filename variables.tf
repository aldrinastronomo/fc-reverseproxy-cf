variable "domain_name" {type = string}

variable "origin_domain" {
    type = list(string)
}
variable "first_origin_domain" {
    type = list(string)
}
variable "second_origin_domain" {
    type = list(string)
}
variable "bucket_prefix" {
    type = list(string)
}


variable "lambda_root_event-type" {type = list(string)}
variable "lambda_root_arn" {type = list(string)}
variable "lambda_obituaries-list_event-type" {type = list(string)}
variable "lambda_obituaries-list_arn" {type = list(string)}
variable "lambda_obituaries-obituary-listings_event-type" {type = list(string)}
variable "lambda_obituaries-obituary-listings_arn" {type = list(string)}
variable "lambda_obituaries_event-type" {type = list(string)}
variable "lambda_obituaries_arn" {type = list(string)}
variable "lambda_scripts_event-type" {type = list(string)}
variable "lambda_scripts_arn" {type = list(string)}
variable "lambda_dependencyhandler_event-type" {type = list(string)}
variable "lambda_dependencyhandler_arn" {type = list(string)}
variable "lambda_content-media_event-type" {type = list(string)}
variable "lambda_content-media_arn" {type = list(string)}
variable "lambda_funhelper_event-type" {type = list(string)}
variable "lambda_funhelper_arn" {type = list(string)}
variable "lambda_obituary-listing_event-type" {type = list(string)}
variable "lambda_obituary-listing_arn" {type = list(string)}
variable "lambda_scripts-myfuneral_event-type" {type = list(string)}
variable "lambda_scripts-myfuneral_arn" {type = list(string)}
variable "lambda_funhelperunsubscribe_event-type" {type = list(string)}
variable "lambda_funhelperunsubscribe_arn" {type = list(string)}
variable "lambda_sitemap_event-type" {type = list(string)}
variable "lambda_sitemap_arn" {type = list(string)}
variable "lambda_obituaries-sitemap_event-type" {type = list(string)}
variable "lambda_obituaries-sitemap_arn" {type = list(string)}



## UNCOMMENT once domains were validated
# variable "aliases" {
#   description = "A list of alias in a list"
#   type        = list(list(string))
# }

variable "is_ipv6_enabled" {
    type = bool
    default = true
}
variable "enabled" {
    type = bool
    default = true
}

variable "custom_1st_origin_config" {
    type = object({
    http_port        = number
    https_port       = number
    origin_protocol_policy = string
    origin_ssl_protocols = list(string)
  })
}

variable "custom_2nd_origin_config" {
    type = object({
    http_port        = number
    https_port       = number
    origin_protocol_policy = string
    origin_ssl_protocols = list(string)
  })
}

## Default path behavior

variable "default_allowed_methods" {
    type = list(string)
    default = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
}
variable "default_cached_methods" {
    type = list(string)
    default = ["GET", "HEAD"]
}
variable "default_compress" {type = bool}
variable "default_viewer_protocol_policy" {}

variable "restrictiontype" {}

variable "include_cookies" {type = bool}
variable "bucket" {}
variable "managedby" {}

# tags
variable "jira_tag" {
    type = list(string)
}
variable "environment" {type = string}