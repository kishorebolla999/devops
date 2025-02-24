provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg-${var.environment}"
  description = "Allow HTTP and SSH"

 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [
    aws_security_group.web_sg.id,
  ]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              echo "<h1>Deployed via Terraform.</h1>" > /usr/share/nginx/html/index.html
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "TerraformWebServer-${var.environment}"
  }
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}




