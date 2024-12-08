variable "ami_name_regex" {
  description = "The name filter for AMI"
  type        = string
  default     = "ubuntu-noble-24.04-amd64*"
}