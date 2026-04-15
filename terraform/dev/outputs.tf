output "bucket_name" {
  value = aws_s3_bucket.rsite.bucket
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.rsite.domain_name
}
