data "aws_caller_identity" "current" {
}
data "aws_cloudfront_distribution" "current" {
  id = aws_cloudfront_distribution
}


locals {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::ACCOUNT_ID_B:root"  # Substitua ACCOUNT_ID_B pelo ID da outra conta
        }
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}",
          "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"
        ]
      }
    ]
  })
}
