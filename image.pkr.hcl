packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "wordpress" {
  ami_name      = "wordpress-linux-aws-{{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ami-087c17d1fe0178315"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["self"]
  }
  ssh_username = "ec2-user"
}

build {
  name = "wordpress-{{timestamp}}"
  sources = [
    "source.amazon-ebs.wordpress"
  ]
}