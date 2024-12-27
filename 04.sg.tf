############## resource ##############
resource "aws_security_group" "terraform-instance-sg" {
    name = "${var.instance_name}-sg"
    description = "Grupo de seguridad que permite el trafico SSH y HTTP"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 30000
        to_port     = 30000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" 
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name        = "${var.instance_name}-sg"
      Environment = "test"
      Owner       = "jgarcia@3htp.com"
      Team        = "DevOps"
      Project     = "Practice DevOps"

    }   
}