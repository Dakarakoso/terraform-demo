output "bucket_name" {
  value = aws_s3_bucket.willian-maruyama-site-101-20260415.bucket
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.willian-maruyama-site-101-20260415.domain_name
}
