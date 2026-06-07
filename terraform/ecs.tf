resource "aws_ecs_cluster" "main" {
  name = "assignment-cluster"
}

#################################################
# CloudWatch
#################################################

resource "aws_cloudwatch_log_group" "frontend" {
  name              = "/ecs/flask-frontend"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "backend" {
  name              = "/ecs/express-backend"
  retention_in_days = 7
}

#################################################
# Backend Task Definition
#################################################

resource "aws_ecs_task_definition" "backend" {

  family                   = "express-backend"
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu    = "256"
  memory = "512"

  execution_role_arn = data.aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name = "express-backend"

      image = "${aws_ecr_repository.backend.repository_url}:latest"

      essential = true

      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.backend.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

#################################################
# Frontend Task Definition
#################################################

resource "aws_ecs_task_definition" "frontend" {

  family                   = "flask-frontend"
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu    = "256"
  memory = "512"

  execution_role_arn = data.aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name = "flask-frontend"

      image = "${aws_ecr_repository.frontend.repository_url}:latest"

      essential = true

      portMappings = [
        {
          containerPort = 5000
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "BACKEND_URL"
          value = "http://${aws_lb.main.dns_name}/api/submit"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.frontend.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

#################################################
# Backend ECS Service
#################################################

resource "aws_ecs_service" "backend" {

  name = "backend-service"

  cluster = aws_ecs_cluster.main.id

  task_definition = aws_ecs_task_definition.backend.arn

  desired_count = 1

  launch_type = "FARGATE"

  network_configuration {

    assign_public_ip = true

    security_groups = [
      aws_security_group.ecs_sg.id
    ]

    subnets = data.aws_subnets.default.ids
  }

  load_balancer {

    target_group_arn = aws_lb_target_group.backend.arn

    container_name = "express-backend"

    container_port = 3000
  }

  depends_on = [
    aws_lb_listener.http
  ]
}

#################################################
# Frontend ECS Service
#################################################

resource "aws_ecs_service" "frontend" {

  name = "frontend-service"

  cluster = aws_ecs_cluster.main.id

  task_definition = aws_ecs_task_definition.frontend.arn

  desired_count = 1

  launch_type = "FARGATE"

  network_configuration {

    assign_public_ip = true

    security_groups = [
      aws_security_group.ecs_sg.id
    ]

    subnets = data.aws_subnets.default.ids
  }

  load_balancer {

    target_group_arn = aws_lb_target_group.frontend.arn

    container_name = "flask-frontend"

    container_port = 5000
  }

  depends_on = [
    aws_lb_listener.http
  ]
}