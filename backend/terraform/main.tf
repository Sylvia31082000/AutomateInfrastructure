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

    lambda_data_table_arns = [
    ]

    api_gateway_type = "REGIONAL"

    # Environment Variables
    lambda_env = local.env

}
