resource "aws_s3_bucket" "aws_s3_bucket" {
  bucket = "s3jltdsjr"

  tags = {
    Name        = "s3-bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = aws_s3_bucket.aws_s3_bucket.id

  tags = {
    Name = "s3_bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block" {
  bucket                  = aws_s3_bucket.s3_bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# policy to allow access from another account
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = local.policy
}