resource "aws_s3_bucket" "bn-dev-tf-state" {
    bucket = "bn-dev-tf-state"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3-encrypt-config" {
    bucket = aws_s3_bucket.bn-dev-tf-state.id
    rule {
        apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
        }
    }
}

resource "aws_s3_bucket_versioning" "bn-tf-versioning" {
  bucket = aws_s3_bucket.bn-dev-tf-state.id
  versioning_configuration {
    status = "Enabled"
  }
}