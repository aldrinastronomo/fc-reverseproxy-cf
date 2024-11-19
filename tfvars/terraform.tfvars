## FILL IN THE REQUIRED FIELDS ##

domain_name = "tippecanoememorygardens"

origin_domain = [
    "tippecanoememorygardens.com",
    "samplenewfh.com",
    "xyz.com"
    ### insert on this line the apex origin domain ###
    ]

first_origin_domain = [
    "origin.tippecanoememorygardens.com",
    "origin.samplenewfh.com",
    "origin.xyz.com"
    ### insert on this line the 1st origin domain ###
    ]

second_origin_domain = [
    "tippecanoememorygardens.secure.tributecenteronline.com",
    "samplenewfh.secure.tributecenteronline.com",
    "xyz.secure.tributecenteronline.com"
    ### insert on this line the 2nd origin domain ###
    ]

bucket_prefix = [
    "tippecanoememorygardens",
    "samplenewfh",
    "xyz"
    ### insert on this line the bucket prefix ###
    ]

# tags
jira_tag = [
    "CO-1315",
    "CO-9999",
    "CO-8888"
    ### insert on this line the Jira ticket number ###
    ]

## UNCOMMENT once domains were validated
# aliases = [
#   ["tippecanoememorygardens.com", "www.tippecanoememorygardens.com"],
#   ["samplenewfh.com", "www.samplenewfh.com"]
# ]

# ssl_cert = [
#   ["asdasdasd"],
#   ["asdasdasda"]
# ]

## for /* path Lambda
lambda_root_event-type = [
    "origin-request",
    "",
    "",
]
lambda_root_arn = [
    "arn:aws:lambda:us-east-1:925691020833:function:obituaries-list:2",
    "",
    "",
]
## for /obituaries-list* path Lambda
lambda_obituaries-list_event-type = [
    "origin-request",
    "",
    "",
]
lambda_obituaries-list_arn = [
    "arn:aws:lambda:us-east-1:925691020833:function:obituaries-list:2",
    "",
    "",
]
## for /obituaries/obituary-listings* path Lambda
lambda_obituaries-obituary-listings_event-type = [
    "",
    "",
    "",
]
lambda_obituaries-obituary-listings_arn = [
    "",
    "",
    "",
]
## for /obituaries/obituary-listings* path Lambda
lambda_obituaries_event-type = [
    "",
    "",
    "",
]
lambda_obituaries_arn = [
    "",
    "",
    "",
]
## for /Scripts* path Lambda
lambda_scripts_event-type = [
    "",
    "",
    "",
]
lambda_scripts_arn = [
    "",
    "",
    "",
]
## for /DependencyHandler.axd/* path Lambda
lambda_dependencyhandler_event-type = [
    "",
    "",
    "",
]
lambda_dependencyhandler_arn = [
    "",
    "",
    "",
]
## for /Content/Media/* path Lambda
lambda_content-media_event-type = [
    "",
    "",
    "",
]
lambda_content-media_arn = [
    "",
    "",
    "",
]
## for /FunHelper/* path Lambda
lambda_funhelper_event-type = [
    "",
    "",
    "",
]
lambda_funhelper_arn = [
    "",
    "",
    "",
]
## for /obituary-listing path Lambda
lambda_obituary-listing_event-type = [
    "",
    "",
    "",
]
lambda_obituary-listing_arn = [
    "",
    "",
    "",
]
## for /Scripts/MyFuneral/* path Lambda
lambda_scripts-myfuneral_event-type = [
    "",
    "",
    "",
]
lambda_scripts-myfuneral_arn = [
    "",
    "",
    "",
]
## for /funhelper/unsubscribeobituarymails* path Lambda
lambda_funhelperunsubscribe_event-type = [
    "",
    "",
    "",
]
lambda_funhelperunsubscribe_arn = [
    "",
    "",
    "",
]
## for /sitemap.xml path Lambda
lambda_sitemap_event-type = [
    "",
    "",
    "",
]
lambda_sitemap_arn = [
    "",
    "",
    "",
]
## for /obituaries-sitemap/* path Lambda
lambda_obituaries-sitemap_event-type = [
    "",
    "",
    "",
]
lambda_obituaries-sitemap_arn = [
    "",
    "",
    "",
]



# Custom origin config 1st origin domain
custom_1st_origin_config = {
    http_port        = 80
    https_port       = 443
    origin_protocol_policy = "match-viewer"
    origin_ssl_protocols = ["TLSv1.2"]
  }
# Custom origin config 2nd origin domain
custom_2nd_origin_config = {
    http_port        = 80
    https_port       = 443
    origin_protocol_policy = "https-only"
    origin_ssl_protocols = ["TLSv1.2"]
  }

enabled = true
is_ipv6_enabled = true

# default path behavior
default_viewer_protocol_policy = "allow-all"
default_allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
default_cached_methods = ["GET", "HEAD"]
default_compress = true

#restrictions - geo_restriction
restrictiontype = "none"

environment = "Prod"
include_cookies = false
bucket = "cloudfront-tmp-logs-dev.s3.amazonaws.com"

managedby = "CloudOps"