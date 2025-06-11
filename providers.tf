terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.80.0"
    }
    local = {
      source  = "registry.terraform.io/hashicorp/local"
      version = "2.5.3"
    }
  }
  required_version = ">= 1.7.1"
}

# uses AWS_REGION env var
# https://developer.hashicorp.com/terraform/language/backend/s3#credentials-and-shared-configuration
provider "aws" {}