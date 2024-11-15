data "aws_caller_identity" "current" {}

# Referencia a distribuição do CloudFront para o bucket S3
data "aws_cloudfront_distribution" "current" {
  id = aws_cloudfront_distribution.s3_distribution.id  # Corrigido: referência para o recurso correto
}

locals {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::397546002821:root"  # Substitua pelo ID da conta correta
        }
        Action   = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.aws_s3_bucket.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.aws_s3_bucket.bucket}/*"
        ]
      }
    ]
  })
}
