# output "frontend_ip" {
#   value = aws_instance.frontend_server.public_ip
# }
#
# output "backend_ip" {
#   value = aws_instance.backend_server.public_ip
# }
#
# output "frontend_url" {
#   value = "http://${aws_instance.frontend_server.public_ip}:5000"
# }
#
# output "backend_url" {
#   value = "http://${aws_instance.backend_server.public_ip}:3000"
# }

output "frontend_ecr_repository_url" {
  value = aws_ecr_repository.frontend.repository_url
}

output "backend_ecr_repository_url" {
  value = aws_ecr_repository.backend.repository_url
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "alb_url" {
  value = "http://${aws_lb.main.dns_name}"
}