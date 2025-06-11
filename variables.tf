variable "ami_name_regex" {
  description = "The name filter for AMI"
  type        = string
  default     = "ubuntu-noble-24.04-amd64*"
}

variable "ssh_private_key" {
  # retrieved from GH secrets
  description = "Private key for SSH to instance"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  # retrieved from GH secrets
  description = "Public key for SSH to instance"
  type        = string
  sensitive   = true
}

variable "ansible_user_password" {
  # retrieved from GH secrets
  description = "Password for ansible user"
  type        = string
  sensitive   = true
}