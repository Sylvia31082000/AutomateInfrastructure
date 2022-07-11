terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "s3-infra-bucket-terraform"
    key = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
   region = local.region
}

locals {
    region  = "ap-southeast-1"
    env     = lower(terraform.workspace)
    project = "validity-api"

    # a list of supported environment & Terraform workspace labels. Each of these labels
    # also corresponds to each Terraform workspace label and should match each one exactly.
    env_dev_label = "dev"

    # Basic Settings
    api_gateway_name                   = "${local.project}"
    api_gateway_name_prefix            = "${local.project}-${local.env}"
    api_gateway_authorizer_name_prefix = local.api_gateway_name
    api_gateway_path_to_openapi        = "./api_specs/api.json"

    lambda_data_table_arns = []

    # VPC Configuration
    lambda_vpc_subnet_ids         = [aws_subnet.public-subnet-1a.id, aws_subnet.public-subnet-1b.id]
    lambda_vpc_security_group_ids = [aws_vpc.infa-vpc.default_security_group_id]

    api_gateway_type = "REGIONAL"

    # Environment Variables
    lambda_env = local.env

}
