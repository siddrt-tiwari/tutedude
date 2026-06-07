# resource "aws_security_group" "fullstack_app_sg" {
#
#   name = "flask-express-sg"
#
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["106.219.172.26/32"]
#   }
#
#   ingress {
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   ingress {
#     from_port   = 5000
#     to_port     = 5000
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   egress {
#
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#
#   }
# }
# resource "aws_instance" "fullstack_server" {
#
#   ami           = var.ami_id
#   instance_type = var.instance_type
#   key_name      = var.key_name
#
#   vpc_security_group_ids = [
#     aws_security_group.app_sg.id
#   ]
#
#   user_data = file("${path.module}/userdata.sh")
#
#   tags = {
#     Name = "Flask-Express-Terraform-Assignment"
#   }
# }

resource "aws_instance" "frontend_server" {

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.frontend_sg.id
  ]

  user_data = file("${path.module}/frontend-user.sh")

  tags = {
    Name = "Flask-Frontend"
  }
}

resource "aws_instance" "backend_server" {

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.backend_sg.id
  ]

  user_data = file("${path.module}/backend-user.sh")

  tags = {
    Name = "Express-Backend"
  }
}

# BACKEND SECURITY GROUP

resource "aws_security_group" "backend_sg" {

  name = "backend-sg"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["106.219.172.26/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# FRONTEND SECURITY GROUP
resource "aws_security_group" "frontend_sg" {

  name = "frontend-sg"

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["106.219.172.26/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}