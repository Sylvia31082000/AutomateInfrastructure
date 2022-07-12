provider "aws" {
    region = "${var.region}"
}

module "s3" {
    source = "./s3"
    bucket_name = "s3-infra-terraform"       
}