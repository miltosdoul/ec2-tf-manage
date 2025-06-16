# ec2-tf-manage
Terraform code to run/bring down an Ubuntu 24.04 AMI on EC2 which uses OIDC to assume AWS role.

 ![Current architecture](/assets/architecture.png) \
Currently uses cloud-init via Terraform to create user and `ansible-playbook` command is called via Terraform `remote-exec`. \
Also uses fail2ban for SSH and rsync to copy the website files on update from the [github.io](https://github.com/miltosdoul/miltosdoul.github.io) repository. \
TODO:
 - Website deployment via webhook on push to website repository
 - Use Elastic IP for static address
