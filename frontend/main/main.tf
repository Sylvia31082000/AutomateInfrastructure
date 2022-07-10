provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.region}"
}

resource "aws_s3_bucket" "bucket" {
    bucket = "s3-validity-bucket" 
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = <<EOF
    {

    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1380877761162",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::s3-validity-bucket/*"
        }
        ]
    }
    EOF
}

resource "aws_s3_bucket_acl" "visibility" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "react" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

output "website_domain" {
    value = "${aws_s3_bucket.bucket.website_domain}"
}

output "website_endpoint" {
    value = "${aws_s3_bucket.bucket.website_endpoint}"
}