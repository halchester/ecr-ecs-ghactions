resource "aws_instance" "my_vite_app" {
  instance_type = var.ec2_instance_type
  ami           = var.ec2_instance_ami
  tags = {
    Name = "my-vite-app"
  }
}
