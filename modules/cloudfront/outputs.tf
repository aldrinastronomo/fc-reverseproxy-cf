#output "cloudfront_domain_name" {
#  value = aws_cloudfront_distribution.this.domain_name
#}

## outputs all the domain name. Sample output should look like this:
## "xyz.com" = abcefg.cloudfront.net
## "123.com" = sfddfgdg.cloudfront.net
## .. .. .. ..
## output name must be called to module.tf output to be able produce an output
output "cloudfront_domain_name" {
  value = [for distribution in aws_cloudfront_distribution.my_distribution : distribution.domain_name]
}