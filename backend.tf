terraform {
  backend "s3" {
    bucket = "ec2-tf-deploy-state-bucket"
    key    = "terraform.tfstate"
    # assume_role uses AWS_ROLE_ARN env var
    # https://developer.hashicorp.com/terraform/language/backend/s3#assume-role-with-web-identity-configuration
    assume_role_with_web_identity = {
      role_arn = ""
    }
  }
}