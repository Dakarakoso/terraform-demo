resource "aws_s3_bucket" "willian-maruyama-site-101" {
  bucket = "${var.project_name}-bucket"
}

resource "aws_s3_bucket_versioning" "willian-maruyama-site-101" {
  bucket = aws_s3_bucket.willian-maruyama-site-101.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "willian-maruyama-site-101" {
  bucket = aws_s3_bucket.willian-maruyama-site-101.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudfront_origin_access_control" "willian-maruyama-site-101" {
  name                              = "${var.project_name}-oac"
  description                       = "Origin Access Control for ${var.project_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "willian-maruyama-site-101" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name              = aws_s3_bucket.willian-maruyama-site-101.bucket_regional_domain_name
    origin_id                = "s3-site-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.willian-maruyama-site-101.id
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "s3-site-origin"
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

data "aws_iam_policy_document" "willian-maruyama-site-101" {
  statement {
    sid    = "AllowCloudFrontServicePrincipalReadOnly"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions = [
      "s3:GetObject",
    ]
    resources = ["${aws_s3_bucket.willian-maruyama-site-101.arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.willian-maruyama-site-101.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "willian-maruyama-site-101" {
  bucket = aws_s3_bucket.willian-maruyama-site-101.id
  policy = data.aws_iam_policy_document.willian-maruyama-site-101.json
}
