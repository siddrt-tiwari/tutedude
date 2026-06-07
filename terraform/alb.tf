resource "aws_lb" "main" {

  name = "assignment-alb"

  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets = data.aws_subnets.default.ids
}

resource "aws_lb_target_group" "frontend" {

  name = "frontend-tg"

  port = 5000

  protocol = "HTTP"

  target_type = "ip"

  vpc_id = data.aws_vpc.default.id
}

resource "aws_lb_target_group" "backend" {

  name = "backend-tg"

  port = 3000

  protocol = "HTTP"

  target_type = "ip"

  vpc_id = data.aws_vpc.default.id
}

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.main.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

resource "aws_lb_listener_rule" "backend" {

  listener_arn = aws_lb_listener.http.arn

  priority = 100

  action {

    type = "forward"

    target_group_arn = aws_lb_target_group.backend.arn
  }

  condition {

    path_pattern {
      values = ["/api/*"]
    }
  }
}