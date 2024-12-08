terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.80.0"
    }
  }
  required_version = ">= 1.1.0"
}

# uses AWS_REGION env var
# https://developer.hashicorp.com/terraform/language/backend/s3#credentials-and-shared-configuration
provider "aws" {}