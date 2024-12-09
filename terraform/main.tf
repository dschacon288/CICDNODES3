provider "aws" {
  region = "us-east-1"
}

##### Creating an S3 Bucket #####
resource "aws_s3_bucket" "app_bucket" {
  bucket         = "${var.env}-application-bucket"
  force_destroy  = true
}

##### Configure Website Hosting #####
resource "aws_s3_bucket_website_configuration" "blog" {
  bucket = aws_s3_bucket.app_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

##### Public Access Block (Optional, if needed) #####
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.app_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

##### Apply Bucket Policy #####
resource "aws_s3_bucket_policy" "app_bucket_policy" {
  bucket = aws_s3_bucket.app_bucket.id

  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "PublicReadGetObject",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.app_bucket.id}/*"
      }
    ]
  }
  POLICY
}