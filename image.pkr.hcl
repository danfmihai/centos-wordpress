packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "wordpress" {
  ami_name      = "wordpress-ami-{{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami    = "ami-087c17d1fe0178315"
  ssh_username  = "ec2-user"
}

build {
  name = "wordpress-{{timestamp}}"
  sources = [
    "source.amazon-ebs.wordpress"
  ]

  provisioner "shell" {
    
    inline = [
            "echo Installing Wordpress version {{WORDPRESS_VERSION}}",
            "echo",
            "sudo yum install httpd wget git -y",
            "sudo yum install php php-mysql -y",
            "sudo yum install php-gd mariadb-server mariadb -y",
            "sudo yum install mysql -y",
            "sudo systemctl start httpd",
            "sudo systemctl enable httpd.service",
            "sudo systemctl start mariadb",
            "sudo systemctl enable mariadb.service",
            "sudo systemctl restart httpd.service",
            "wget https://wordpress.org/wordpress-{{WORDPRESS_VERSION}}.tar.gz",
            "tar xzvf {{WORDPRESS_VERSION}}*",
            "sudo rsync -avP ~/wordpress/ /var/www/html/",
            "mkdir /var/www/html/wp-content/uploads",
            "sudo chown -R apache:apache /var/www/html/*"
            "echo ",
            "echo Installation of Wordpress done!"    
    ]
}

}