output "instance_public_up" {
  value = module.ec2_app.public_ip
}

output "instance_public_dns" {
  value = module.ec2_app.public_dns
}
