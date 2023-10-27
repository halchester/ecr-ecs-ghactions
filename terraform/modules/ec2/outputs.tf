output "instance_public_ip" {
  value = aws_instance.my_vite_app.public_ip
}

output "instance_public_dns" {
  value = aws_instance.my_vite_app.public_dns
}
