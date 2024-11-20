## this local is for the policies that have long strings
locals {
  ordered_origin_request_policy = {
    all_viewer = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    all_viewer_except_host_header = "b689b0a8-53d0-40ab-baf2-68738e2966ac"
  }
  cache_policy = {
    caching_optimized = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    caching_disabled = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    UseOriginCacheControlHeaders = "83da9c7e-98b4-4e11-a168-04f0df8e2c65"
  }
}