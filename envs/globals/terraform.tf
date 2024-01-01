# tfstateバケットを作成
resource "aws_s3_bucket" "tfstate" {
  bucket = "detailed-explanation-terraform"

  lifecycle {
    prevent_destroy = true
  } 
}

# tfstateバケットをバージョニング有効化
resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

# tfstateバケットを暗号化
resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  } 
}

# tfstateバケットへのpublicアクセスを拒否
resource "aws_s3_bucket_public_access_block" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
  
}

# locks用のdynamoテーブルを作成

resource "aws_dynamodb_table" "tfstate-locks" {
  name = "tfstate-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }


  lifecycle {
    prevent_destroy = true
  }
}


