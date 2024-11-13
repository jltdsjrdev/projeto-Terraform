resource "aws_s3_bucket" "aws_s3_bucket" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "s3jltdsjr"
    Environment = "Dev"
  }
}