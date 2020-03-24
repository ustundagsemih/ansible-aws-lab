provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

resource "aws_instance" "ansible-master" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.ansible-lab-key-pair.key_name


  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("keys/terraform-key-pair")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y",
      "sudo dnf install ansible -y"
    ]
  }

  tags = {
    Name        = var.ansible_control_name
    Environment = var.environment_type[0]
  }
}

resource "aws_instance" "ansible-nodes" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.ansible-lab-key-pair.key_name
  count         = 3

  tags = {
    count       = 3
    Name        = var.ansible_nodes_name[count.index]
    Environment = var.environment_type[0]
  }
}

resource "aws_key_pair" "ansible-lab-key-pair" {
  key_name   = var.key_name
  public_key = file("keys/terraform-key-pair.pub")
}
