output "s3-tf-name" {
  value = aws_s3_bucket.bn-dev-tf-state.bucket
  description = "tf state bucket arn"
}