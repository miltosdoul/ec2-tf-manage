resource "local_file" "ansible_inventory" {
  content = templatefile("${path.root}/ansible/inventory.tpl", {
    instance_ip = aws_instance.ec2-instance.public_ip
  })
  filename = "${path.root}/ansible/inventory"

  depends_on = [aws_instance.ec2-instance]
}

# Required for ansible command
# No triggers_replace so it runs every time
# resource "terraform_data" "setup_known_hosts" {
#   provisioner "local-exec" {
#     command = <<-EOT
#       mkdir -p ~/.ssh
#       ssh-keyscan -H ${aws_instance.ec2-instance.public_ip} >> ~/.ssh/known_hosts
#     EOT
#   }

#   depends_on = [aws_instance.ec2-instance]
# }

# Do healthcheck on instance and then run ansible command
resource "terraform_data" "ansible" {
  provisioner "remote-exec" {
    connection {
      host        = aws_instance.ec2-instance.public_ip
      user        = "ansible"
      private_key = var.ssh_private_key
    }
    inline = ["echo 'Hello world'"]
  }
  provisioner "local-exec" {
    command = "ansible-playbook --timeout 180 -i ${path.root}/ansible/inventory ${path.root}/ansible/playbook.yml --vault-password-file ${path.root}/ansible/.vault_pass"
    environment = {
      ANSIBLE_CONFIG = "${path.root}/ansible/ansible.cfg"
    }
  }

  depends_on = [aws_instance.ec2-instance, local_file.ansible_inventory]
  triggers_replace = [
    local_file.ansible_inventory
  ]
}
