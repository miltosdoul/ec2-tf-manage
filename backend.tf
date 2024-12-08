terraform {
  backend "s3" {
    bucket = "ec2-tf-deploy-state-bucket"
    key    = "terraform.tfstate"
    region = var.aws_region

    assume_role = {
      role_arn = "arn:aws:iam::${var.aws_account_id}:role/${var.aws_terraform_role}"
    }
  }
}