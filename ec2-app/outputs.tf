output "instance_id" {
  description = "EC2 Instance ID for deliverable submission"
  value       = aws_instance.app.id
}

output "public_ip" {
  description = "Public IPv4 address of the EC2 instance"
  value       = aws_instance.app.public_ip
}
