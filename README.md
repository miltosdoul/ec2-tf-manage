# ec2-tf-manage
Terraform code to run/bring down an Ubuntu 24.04 AMI on EC2 which uses OIDC to assume AWS role. \

 ![Current architecture](/assets/architecture.png)
Current security groups permit port 22 ingress and all egress. \
TODO:
 - Create a private VPC and add internet gateway in front
 - Automate Route53 record deployment
 - Add Ansible playbook to set up firewall rules and dependencies (Docker etc.)
 - Integrate with ECR
 - Create separate TF repository to create Terraform role and policies
 - Create separate module for instance
 - Automate SSH setup on creation via TF
