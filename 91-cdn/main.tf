resource "aws_cloudfront_distribution" "roboshop" {
  # Cloud front creation
  origin {
    domain_name = "${var.environment}.${var.zone_name}" # Point to your actual backend domain  - dev.devopslearning.store 
    origin_id  = "${var.environment}.${var.zone_name}"  # Point to your actual backend domain  - dev.devopslearning.store 
    custom_origin_config  {
        http_port              = 80 // Required to be set but not used
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  enabled = true
  aliases = ["cdn.${var.zone_name}"] # This is the CloudFront alias (CDN endpoint)

  # Cloudefront default Cache behavior for all traffic
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.environment}.${var.zone_name}" # must match with origin_id

    viewer_protocol_policy = "https-only"
    cache_policy_id  = data.aws_cloudfront_cache_policy.cacheDisable.id
  }

  # Cloudefront Cache behavior for /media/*
  ordered_cache_behavior {
    path_pattern     = "/media/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${var.environment}.${var.zone_name}" # must match with origin_id

    viewer_protocol_policy = "https-only"
    cache_policy_id  = data.aws_cloudfront_cache_policy.cacheEnable.id
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations = ["IN", "US", "CA", "GB", "DE"] # add IN if you want India
    }
  }

  tags = merge(
    local.common_tags,{
        Name = "${var.project}-${var.environment}"
    }
  )

  viewer_certificate {
    acm_certificate_arn = local.acm_certificate_arn
    ssl_support_method = "sni-only"
  }
}

# Route53 record for Cloudfront - CDN
resource "aws_route53_record" "frontend_alb" {
  zone_id = var.zone_id
  name    = "cdn.${var.zone_name}" #cdn.devopslearning.store
  type    = "A"

  alias {
    name = aws_cloudfront_distribution.roboshop.domain_name
    zone_id = aws_cloudfront_distribution.roboshop.hosted_zone_id
    evaluate_target_health = true
  }
}