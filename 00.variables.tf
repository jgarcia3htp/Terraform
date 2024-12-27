############## variables ##############
variable "ami_id" {
    description = "ID de la AMI para la instancia EC2"
    default = "ami-0e2c8caa4b6378d8c"
}

variable "instance_type" {
    description = "Tipo de instancia EC2"
    default = "t2.medium"
}

variable "instance_name" {
    description = "Nombre de la instancia"
    default = "terraform-instance"
}