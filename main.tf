data "aws_security_group" "existing_sg" {
    name = "default"
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "web-server" {
    ami = "ami-01816d07b1128cd2d"
    instance_type = "t2.micro"

    user_data = <<-EOF
                    #!/bin/bash
                    apt update
                    apt install docker.io
                    systemctl enable docker
                    systemctl start docker
                EOF
    
    key_name = "llaves-ec2-2"
    #key_name = aws_key_pair.terraform-instance-ssh.key_name
    #security_groups = [data.aws_security_group.existing_sg]
    vpc_security_group_ids = [
        aws_security_group.terraform-instance-sg.id
    ]

    tags = {
      Name        = "terraform-server"
      Environment = "test"
      Owner       = "jgarcia@3htp.com"
      Team        = "DevOps"
      Project     = "Practice DevOps"

    }    
}

resource "aws_key_pair" "terraform-instance-ssh" {
    key_name = "terraform-instance-ssh"
    public_key = file("terraform-instance-key.pub")

    tags = {
      Name        = "terraform-server-ssh"
      Environment = "test"
      Owner       = "jgarcia@3htp.com"
      Team        = "DevOps"
      Project     = "Practice DevOps"

    }   

}

resource "aws_security_group" "terraform-instance-sg" {
    name = "terraform-instance-sg"
    description = "Grupo de seguridad que permite el trafico SSH y HTTP"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]  # Permite acceso SSH desde cualquier IP
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]  # Permite acceso HTTP desde cualquier IP
    }

        ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]  # Permite acceso HTTP desde cualquier IP
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"  # Permite todo el tráfico de salida
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name        = "terraform-server-sg"
      Environment = "test"
      Owner       = "jgarcia@3htp.com"
      Team        = "DevOps"
      Project     = "Practice DevOps"

    }   
}

output "server_public_ip" {
	description = "Direccion IP publica de la instancia EC2"
	value       = aws_instance.web-server.public.ip 
}
