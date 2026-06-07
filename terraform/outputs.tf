output "frontend_ip" {
  value = aws_instance.frontend_server.public_ip
}

output "backend_ip" {
  value = aws_instance.backend_server.public_ip
}

output "frontend_url" {
  value = "http://${aws_instance.frontend_server.public_ip}:5000"
}

output "backend_url" {
  value = "http://${aws_instance.backend_server.public_ip}:3000"
}