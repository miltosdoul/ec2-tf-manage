variable "aws_account_id" {
  type        = string
  description = "Provided via workflow's environment"
}

variable "aws_terraform_role" {
  type        = string
  description = "Provided via workflow's environment"
}

variable "ami_name_regex" {
  description = "The name filter for AMI"
  type        = string
  default     = "Ubuntu Server 24.04 LTS*"
}