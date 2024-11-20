provider "aws" {
  region = var.region
}

module "cloudfront_distribution_1" {
  source          = "./modules/cloudfront"
# distribution_id = "distribution1"
  origins         = var.distribution_1_origins
#  acm_certificate = var.distribution_1_acm_arn
#  aliases         = var.distribution_1_aliases
}

module "cloudfront_distribution_2" {
  source          = "./modules/cloudfront"
#  distribution_id = ""
  origins         = var.distribution_2_origins
#  acm_certificate = var.distribution_2_acm_arn
#  aliases         = var.distribution_2_aliases
}