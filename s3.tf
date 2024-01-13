resource "aws_s3_bucket" "frontend" {
  bucket        = "${local.resource_prefix}-frontend"
  force_destroy = false
}
resource "aws_s3_bucket_cors_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
}

resource "aws_cloudfront_origin_access_identity" "frontend" {
  comment = "${local.resource_prefix}-frontend_origin_access_identity"
}
resource "aws_s3_bucket_policy" "frontend" {
  bucket = aws_s3_bucket.frontend.id
  policy = <<EOF
{
    "Version": "2012-10-17",
     "Statement": [
         {
             "Sid": "PublicReadGetObject",
             "Effect": "Allow",
             "Action": ["s3:GetObject"],
             "Resource": "${aws_s3_bucket.frontend.arn}/*",
         }
     ]
}
EOF
}
