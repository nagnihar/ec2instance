resource "aws_instance" "my_ec2" {
  ami           = "ami-04999cd8f2624f834"  # amazon linux (oregon)
  instance_type = "t2.micro"
  key_name      = "NAG-KEY"   
  vpc_security_group_ids      = [aws_security_group.allow_web_ssh_8080.id]  # ✅ SG attach
  associate_public_ip_address = true                    # ✅ public IP enable చేయడం

  tags = {
    Name = "MyTf-WEBSERVER"
  }
}

resource "aws_security_group" "allow_web_ssh_8080" {
  name        = "allow_web_ssh_8080"
  description = "Allow SSH, HTTP, HTTPS and 8080 from anywhere"
  vpc_id      = "vpc-061916f0d0f8bd63d"  # మీ VPC ID ఇక్కడ పెట్టండి

  # SSH - 22
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP - 80
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS - 443
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Custom Port - 8080
  ingress {
    description = "Custom App Port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress: Allow all outgoing
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web_ssh_8080"
  }
}
