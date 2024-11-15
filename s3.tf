# Definição do bucket S3
resource "aws_s3_bucket" "aws_s3_bucket" {
  bucket = "my-bucket-jr"
}

# Carregar o arquivo index.html para o bucket S3
resource "aws_s3_object" "example_index_s3" {
  bucket = aws_s3_bucket.aws_s3_bucket.bucket
  key    = "index.html"
  source = "index.html"
}

# Criação da identidade de acesso do CloudFront (OAI)
resource "aws_cloudfront_origin_access_identity" "cloudfront_access_identity" {
  comment = "Access identity for CloudFront"
}
