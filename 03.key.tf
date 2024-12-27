############## resource ##############
resource "aws_key_pair" "terraform-instance-ssh" {
    key_name = "${var.instance_name}-ssh"
    public_key = file (var.public_key)

    tags = {
      Name        = "${var.instance_name}-ssh"
      Environment = "test"
      Owner       = "jgarcia@3htp.com"
      Team        = "DevOps"
      Project     = "Practice DevOps"
    }   
}