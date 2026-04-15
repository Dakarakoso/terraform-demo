output "bucket_name" {
  value = aws_s3_bucket.raquel-willian-tulipa-random-123-321-test.bucket
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.raquel-willian-tulipa-random-123-321-test.domain_name
}
