# Definição do bucket S3
resource "aws_s3_bucket" "aws_s3_bucket" {
  bucket = "my-bucket-jr"  
}

# Carregar o arquivo index.html para o bucket S3
resource "aws_s3_object" "example_index_s3" {
  bucket = aws_s3_bucket.aws_s3_bucket.bucket  # Referência ao bucket
  key    = "index.html"  # Nome do arquivo no S3
  source = "index.html"  # O caminho para o arquivo local
  
}

# Criação da identidade de acesso do CloudFront (OAI)
resource "aws_cloudfront_origin_access_identity" "cloudfront_access_identity" {
  comment = "Access identity for CloudFront"
}

# Criação da distribuição do CloudFront
resource "aws_cloudfront_distribution" "example_distribution_s3" {
  origin {
    domain_name = aws_s3_bucket.aws_s3_bucket.bucket_regional_domain_name  # Usando o nome do domínio regional do bucket
    origin_id   = "S3-my-bucket-jr-origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront_access_identity.id
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Exemplo de distribuição CloudFront para um bucket S3"
  default_root_object = "index.html"

  # Configuração do comportamento de cache
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-my-bucket-jr-origin"  # Correspondente ao origin_id definido acima

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Restrições geográficas (opcional)
  restrictions {
    geo_restriction {
      restriction_type = "none"  # Pode ser "whitelist" ou "blacklist" para limitar países
    }
  }

  # Configuração do certificado SSL (opcional)
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
