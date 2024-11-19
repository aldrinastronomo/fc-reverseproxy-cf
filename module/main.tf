# Create a CloudFront distribution
resource "aws_cloudfront_distribution" "my_distribution" {

   count = length(var.origin_domain)
  
  origin {
    domain_name = var.first_origin_domain[count.index]
    origin_id   = var.first_origin_domain[count.index]  # Unique identifier for the first origin

    custom_origin_config {
      http_port                = var.custom_1st_origin_config.http_port
      https_port               = var.custom_1st_origin_config.https_port
      origin_protocol_policy   = var.custom_1st_origin_config.origin_protocol_policy
      origin_ssl_protocols     = var.custom_1st_origin_config.origin_ssl_protocols
    }
  }

  origin {
    domain_name = var.second_origin_domain[count.index] # Second origin domain
    origin_id   = var.second_origin_domain[count.index]  # Unique identifier for the second origin

    custom_origin_config {
      http_port                = var.custom_2nd_origin_config.http_port
      https_port               = var.custom_2nd_origin_config.https_port
      origin_protocol_policy   = var.custom_2nd_origin_config.origin_protocol_policy
      origin_ssl_protocols     = var.custom_2nd_origin_config.origin_ssl_protocols
    }
  }

  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  comment             = format("Tribute Pages Reverse Proxy for %s", var.origin_domain[count.index])
  default_root_object = "index.html"

  ## UNCOMMENT once domains were validated
  # aliases = var.aliases[count.index]

  viewer_certificate {
    cloudfront_default_certificate = true
    # acm_certificate_arn      = "arn:aws:acm:us-east-1:020453838980:certificate/5d3140d3-c17b-4317-8aa0-72d5bcde28f8"
    # ssl_support_method       = "sni-only"
    # minimum_protocol_version = "TLSv1.2_2021"
  }

  # site.com
  default_cache_behavior {
    target_origin_id       = var.first_origin_domain[count.index]  # Route default requests to the first origin
    viewer_protocol_policy = var.default_viewer_protocol_policy
    allowed_methods        = var.default_allowed_methods
    cached_methods         = var.default_cached_methods
    compress               = var.default_compress

    cache_policy_id            = local.cache_policy.UseOriginCacheControlHeaders # CachePolicy: CachingDisabled
    origin_request_policy_id   = local.ordered_origin_request_policy.all_viewer  # OriginRequestPolicy: AllViewer

    lambda_function_association {
      event_type   = var.lambda_root_event-type[count.index]                                            ### should be lambda_root_event-type
      lambda_arn   = var.lambda_root_arn[count.index]                           ### should be lambda_root_arn
      include_body = false
    }
  }

  # Additional cache behavior for the second origin
  ordered_cache_behavior {
    path_pattern     = "/obituaries-list*"
    target_origin_id = var.second_origin_domain[count.index]  # Route requests matching this pattern to the second origin
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    cache_policy_id          = local.cache_policy.UseOriginCacheControlHeaders
    origin_request_policy_id = local.ordered_origin_request_policy.all_viewer  # OriginRequestPolicy: AllViewer
    
    lambda_function_association {
      event_type   = var.lambda_obituaries-list_event-type[count.index]                                                ### should be lambda_obituaries-list_event-type
      lambda_arn   = var.lambda_obituaries-list_arn[count.index]                        ### should be lambda_obituaries-list_arn
      include_body = false
    }
  }

  # 3rd Additional cache behavior
  ordered_cache_behavior {
    path_pattern     = "/obituaries/obituary-listings*"
    target_origin_id = var.second_origin_domain[count.index]  # Route requests matching this pattern to the second origin
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    cache_policy_id          = local.cache_policy.UseOriginCacheControlHeaders # CachePolicy: CachingOptimized
    origin_request_policy_id = local.ordered_origin_request_policy.all_viewer # AllViewer

    lambda_function_association {
      event_type   = var.lambda_obituaries-list_event-type[count.index]                  ### should be lambda_obituaries-list_event-type
      lambda_arn   = var.lambda_obituaries-list_arn[count.index]                        ### should be lambda_obituaries-list_arn
      include_body = false
    }
  }

  # 4th Additional cache behavior
  ordered_cache_behavior {
    path_pattern     = "/obituaries/*"
    target_origin_id = var.second_origin_domain[count.index]  # Route requests matching this pattern to the second origin
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    cache_policy_id          = local.cache_policy.UseOriginCacheControlHeaders # CachePolicy: CachingOptimized
    origin_request_policy_id = local.ordered_origin_request_policy.all_viewer # AllViewer

    lambda_function_association {
      event_type   = var.lambda_obituaries-list_event-type[count.index]                  ### should be lambda_obituaries-list_event-type
      lambda_arn   = var.lambda_obituaries-list_arn[count.index]                        ### should be lambda_obituaries-list_arn
      include_body = false
    }
  }

  # 5th Additional cache behavior
  ordered_cache_behavior {
    path_pattern     = "/Scripts/*"
    target_origin_id = var.second_origin_domain[count.index]  # Route requests matching this pattern to the second origin
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    cache_policy_id          = local.cache_policy.UseOriginCacheControlHeaders # CachePolicy: CachingOptimized
    origin_request_policy_id = local.ordered_origin_request_policy.all_viewer # AllViewer

    lambda_function_association {
      event_type   = var.lambda_scripts_event-type[count.index]                  ### should be lambda_obituaries-list_event-type
      lambda_arn   = var.lambda_scripts_arn[count.index]                        ### should be lambda_obituaries-list_arn
      include_body = false
    }
  }

  # 6th Additional cache behavior
  ordered_cache_behavior {
    path_pattern     = "/DependencyHandler.axd/*"
    target_origin_id = var.second_origin_domain[count.index]  # Route requests matching this pattern to the second origin
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    cache_policy_id          = local.cache_policy.UseOriginCacheControlHeaders # CachePolicy: CachingOptimized
    origin_request_policy_id = local.ordered_origin_request_policy.all_viewer # AllViewer
  
    lambda_function_association {
      event_type   = var.lambda_dependencyhandler_event-type[count.index]                  ### should be lambda_obituaries-list_event-type
      lambda_arn   = var.lambda_dependencyhandler_arn[count.index]                        ### should be lambda_obituaries-list_arn
      include_body = false
    }
  }

  # 7th Additional cache behavior
  ordered_cache_behavior {
    path_pattern     = "/Content/Media/*"
    target_origin_id = var.second_origin_domain[count.index]  # Route requests matching this pattern to the second origin
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    cache_policy_id          = local.cache_policy.UseOriginCacheControlHeaders # CachePolicy: CachingOptimized
    origin_request_policy_id = local.ordered_origin_request_policy.all_viewer # AllViewer

    lambda_function_association {
      event_type   = var.lambda_content-media_event-type[count.index]                  ### should be lambda_obituaries-list_event-type
      lambda_arn   = var.lambda_content-media_arn[count.index]                        ### should be lambda_obituaries-list_arn
      include_body = false
    }
  }

  # 8th Additional cache behavior
  ordered_cache_behavior {
    path_pattern     = "/FunHelper/*"
    target_origin_id = var.second_origin_domain[count.index]  # Route requests matching this pattern to the second origin
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    cache_policy_id          = local.cache_policy.UseOriginCacheControlHeaders # CachePolicy: CachingOptimized
    origin_request_policy_id = local.ordered_origin_request_policy.all_viewer # AllViewer

    lambda_function_association {
      event_type   = var.lambda_funhelper_event-type[count.index]                  ### should be lambda_obituaries-list_event-type
      lambda_arn   = var.lambda_funhelper_arn[count.index]                        ### should be lambda_obituaries-list_arn
      include_body = false
    }
  }
  
  # 9th Additional cache behavior /obituary-listing
  ordered_cache_behavior {
    path_pattern     = "/obituary-listing"
    target_origin_id = var.second_origin_domain[count.index]  # Route requests matching this pattern to the second origin
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    cache_policy_id          = local.cache_policy.UseOriginCacheControlHeaders # CachePolicy: CachingOptimized
    origin_request_policy_id = local.ordered_origin_request_policy.all_viewer # AllViewer

    lambda_function_association {
      event_type   = var.lambda_obituary-listing_event-type[count.index]                  ### should be lambda_obituaries-list_event-type
      lambda_arn   = var.lambda_obituary-listing_arn[count.index]                        ### should be lambda_obituaries-list_arn
      include_body = false
    }
  }
  # 9th Additional cache behavior /Scripts/MyFuneral/*
    ordered_cache_behavior {
    path_pattern     = "/Scripts/MyFuneral/*"
    target_origin_id = var.second_origin_domain[count.index]  # Route requests matching this pattern to the second origin
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    cache_policy_id          = local.cache_policy.UseOriginCacheControlHeaders # CachePolicy: CachingOptimized
    origin_request_policy_id = local.ordered_origin_request_policy.all_viewer # AllViewer

    lambda_function_association {
      event_type   = var.lambda_scripts-myfuneral_event-type[count.index]                  ### should be lambda_obituaries-list_event-type
      lambda_arn   = var.lambda_scripts-myfuneral_arn[count.index]                        ### should be lambda_obituaries-list_arn
      include_body = false
    }
  }
  # 10th Additional cache behavior /funhelper/unsubscribeobituarymails*
    ordered_cache_behavior {
    path_pattern     = "/funhelper/unsubscribeobituarymails*"
    target_origin_id = var.second_origin_domain[count.index]  # Route requests matching this pattern to the second origin
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    cache_policy_id          = local.cache_policy.UseOriginCacheControlHeaders # CachePolicy: CachingOptimized
    origin_request_policy_id = local.ordered_origin_request_policy.all_viewer # AllViewer

    lambda_function_association {
      event_type   = var.lambda_funhelperunsubscribe_event-type[count.index]                  ### should be lambda_obituaries-list_event-type
      lambda_arn   = var.lambda_funhelperunsubscribe_arn[count.index]                        ### should be lambda_obituaries-list_arn
      include_body = false
    }
  }
  # 11th Additional cache behavior /sitemap.xml
    ordered_cache_behavior {
    path_pattern     = "/sitemap.xml"
    target_origin_id = var.second_origin_domain[count.index]  # Route requests matching this pattern to the second origin
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    cache_policy_id          = local.cache_policy.UseOriginCacheControlHeaders # CachePolicy: CachingOptimized
    origin_request_policy_id = local.ordered_origin_request_policy.all_viewer # AllViewer

    lambda_function_association {
      event_type   = var.lambda_funhelperunsubscribe_event-type[count.index]                  ### should be lambda_obituaries-list_event-type
      lambda_arn   = var.lambda_funhelperunsubscribe_arn[count.index]                        ### should be lambda_obituaries-list_arn
      include_body = false
    }
  }
  # 12th Additional cache behvior /obituaries-sitemap/*
    ordered_cache_behavior {
    path_pattern     = "/obituaries-sitemap/*"
    target_origin_id = var.second_origin_domain[count.index]  # Route requests matching this pattern to the second origin
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    cache_policy_id          = local.cache_policy.UseOriginCacheControlHeaders # CachePolicy: CachingOptimized
    origin_request_policy_id = local.ordered_origin_request_policy.all_viewer # AllViewer

    lambda_function_association {
      event_type   = var.lambda_obituaries-sitemap_event-type[count.index]                  ### should be lambda_obituaries-list_event-type
      lambda_arn   = var.lambda_obituaries-sitemap_arn[count.index]                        ### should be lambda_obituaries-list_arn
      include_body = false
    }
  }
  
  restrictions {
    geo_restriction {
      restriction_type = var.restrictiontype
    }
  }

  logging_config {
    include_cookies = var.include_cookies
    bucket          = var.bucket
    prefix          = var.bucket_prefix[count.index]
  }

  tags = {
    Jira        = var.jira_tag[count.index]
    ManagedBy   = var.managedby
    Environment = var.environment
  }
}

