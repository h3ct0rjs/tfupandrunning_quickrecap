
resource "aws_lb" "alb-web-farm" {
  name               = "alb-web-farm-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-web-farm-sg.id]
  subnets            = data.aws_subnet_ids.defaultsubnets.ids

  enable_deletion_protection = false

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_listener" "alb-web-listener" {
  load_balancer_arn = aws_lb.alb-web-farm.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: Page not found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_target_group" "tg-web-farm" {
  name     = "tg-web-farm-${var.environment}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = 8080
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Environment = var.environment
  }
}


resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.alb-web-listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-web-farm.arn
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }

}

