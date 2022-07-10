resource "aws_s3_bucket" "bucket" {
    bucket = "${var.bucket_name}" 
}

resource "aws_s3_bucket_acl" "visibility" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "${var.acl_value}" 
}