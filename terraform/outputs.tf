output "instance_public_up" {
  value = module.ec2_app.instance_public_ip
}

output "instance_public_dns" {
  value = module.ec2_app.instance_public_dns
}
