resource "aws_dynamodb_table" "bn-dev-tf-locks" {
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    name = "bn-dev-tf-locks"
    
    attribute {
        name = "LockID"
        type = "S"
    }
}

terraform {
    backend "s3" {
      bucket = "bn-dev-tf-state"

      region = "us-east-1"
      key = "bn/dev/database/dynamo/terraform.tfstate"

      encrypt = true
    }
}