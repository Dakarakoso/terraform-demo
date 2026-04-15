output "bucket_name" {
  value = aws_s3_bucket.maruyama-site-101-20260415-1029380192380-test.bucket
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.maruyama-site-101-20260415-1029380192380-test.domain_name
}
