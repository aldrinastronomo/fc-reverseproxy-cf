provider "aws" {
  region = "us-east-1"
}

module "my_cloudfront_module" {
  source = "./module"
  
  domain_name = var.domain_name
  origin_domain = var.origin_domain
  
  first_origin_domain = var.first_origin_domain
  second_origin_domain = var.second_origin_domain
  ## aliases = var.aliases ## UNCOMMENT once domains were validated

  bucket_prefix = var.bucket_prefix
  bucket = var.bucket
  include_cookies = var.include_cookies
  enabled = var.enabled
  is_ipv6_enabled = var.is_ipv6_enabled

  custom_1st_origin_config = var.custom_1st_origin_config
  custom_2nd_origin_config = var.custom_2nd_origin_config

  ## Lambda@Edge configs for behavior paths
  lambda_root_event-type = var.lambda_root_event-type
  lambda_root_arn = var.lambda_root_arn
  lambda_obituaries-list_event-type = var.lambda_obituaries-list_event-type
  lambda_obituaries-list_arn = var.lambda_obituaries-list_arn
  lambda_obituaries-obituary-listings_event-type = var.lambda_obituaries-obituary-listings_event-type
  lambda_obituaries-obituary-listings_arn = var.lambda_obituaries-obituary-listings_arn
  lambda_obituaries_event-type = var.lambda_obituaries_event-type
  lambda_obituaries_arn = var.lambda_obituaries_arn
  lambda_scripts_event-type = var.lambda_scripts_event-type
  lambda_scripts_arn = var.lambda_scripts_arn
  lambda_dependencyhandler_event-type = var.lambda_dependencyhandler_event-type
  lambda_dependencyhandler_arn = var.lambda_dependencyhandler_arn
  lambda_content-media_event-type = var.lambda_content-media_event-type
  lambda_content-media_arn = var.lambda_content-media_arn
  lambda_funhelper_event-type = var.lambda_funhelper_event-type
  lambda_funhelper_arn = var.lambda_funhelper_arn
  lambda_obituary-listing_event-type = var.lambda_obituary-listing_event-type
  lambda_obituary-listing_arn = var.lambda_obituary-listing_arn
  lambda_scripts-myfuneral_event-type = var.lambda_scripts-myfuneral_event-type
  lambda_scripts-myfuneral_arn = var.lambda_scripts-myfuneral_arn
  lambda_funhelperunsubscribe_event-type = var.lambda_funhelperunsubscribe_event-type
  lambda_funhelperunsubscribe_arn = var.lambda_funhelperunsubscribe_arn
  lambda_sitemap_event-type = var.lambda_sitemap_event-type
  lambda_sitemap_arn = var.lambda_sitemap_arn
  lambda_obituaries-sitemap_event-type = var.lambda_obituaries-sitemap_event-type
  lambda_obituaries-sitemap_arn = var.lambda_obituaries-sitemap_arn  

  ## Default path behavior
  default_viewer_protocol_policy = var.default_viewer_protocol_policy
  default_allowed_methods = var.default_allowed_methods
  default_cached_methods = var.default_cached_methods
  default_compress = var.default_compress

  restrictiontype = var.restrictiontype

  # tags
  environment = var.environment
  managedby = var.managedby
  jira_tag = var.jira_tag

}

output "cloudfront_domain_name" {
   value = { for idx, domain in module.my_cloudfront_module.cloudfront_domain_name : var.origin_domain[idx] => domain }
 }