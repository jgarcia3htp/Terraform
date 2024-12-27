############## output ##############
output "server_public_ip" {
	description = "Direccion IP publica de la instancia EC2"
	value       = aws_instance.terraform-instance.public_ip
}