data "aws_caller_identity" "current" {}

data "aws_cloudfront_distribution" "current" {
  id = aws_cloudfront_distribution.example_distribution_s3.id  # Certifique-se de que o ID da distribuição esteja correto
}

locals {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::397546002821:root"  # Substitua 123456789012 pelo ID da outra conta
        }
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.aws_s3_bucket.id}",
          "arn:aws:s3:::${aws_s3_bucket.aws_s3_bucket.id}/*"
        ]
      }
    ]
  })
}
