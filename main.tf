data "aws_ami" "ubuntu" {
  name_regex  = var.ami_name_regex
  most_recent = true

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # canonical
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_ssh.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

resource "aws_security_group" "allow_all_egress" {
  name        = "allow_all_egress"
  description = "Allow all egress traffic from all protocols"

  tags = {
    Name = "allow_all_egress"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress" {
  security_group_id = aws_security_group.allow_all_egress.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "main-instance-ssh-key"
  public_key = var.ssh_public_key
}

resource "aws_instance" "ec2-instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id, aws_security_group.allow_all_egress.id]

  key_name = aws_key_pair.ssh_key

  user_data = <<-EOF
    #cloud-config
    ssh_pwauth: false
    users:
      - name: ansible
        groups: sudo
        shell: /bin/bash
        sudo: ['ALL=(ALL:ALL) ALL']
        ssh_authorized_keys:
          - ${var.ssh_public_key}
        lock_passwd: false
    chpasswd:
      expire: false
      users:
      - {name: ansible, password: ${var.ansible_user_password}, type: text}
  EOF

  tags = {
    Name = "main_instance"
  }
}