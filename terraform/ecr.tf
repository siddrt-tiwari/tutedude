resource "aws_ecr_repository" "frontend" {
  name = "flask-frontend"
}

resource "aws_ecr_repository" "backend" {
  name = "express-backend"
}