############## resource ##############
resource "aws_instance" "terraform-instance" {
    ami = var.ami_id
    instance_type = var.instance_type

    user_data = "${file("config.sh")}"
    
    key_name = aws_key_pair.terraform-instance-ssh.key_name
    vpc_security_group_ids = [
        aws_security_group.terraform-instance-sg.id
    ]

    root_block_device {
      volume_size           = 58
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = false
    } 

    tags = {
      Name        = var.instance_name
      Environment = "test"
      Owner       = "jgarcia@3htp.com"
      Team        = "DevOps"
      Project     = "Practice DevOps"

    }    
}