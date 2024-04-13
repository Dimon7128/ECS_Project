
resource "aws_security_group" "alb_sg" {
  name        = "${var.alb_name}-sg"
  description = "Security group for ALB allowing ports 80 and 443"
  vpc_id      = var.vpc_id


  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags_alb
}


resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnets

  enable_deletion_protection = false
  tags = var.tags_alb
}


resource "aws_lb_target_group" "tg" {
  name     = var.alb_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip" 
  health_check {
    enabled             = true
    interval            = var.health_check_interval
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    path                = var.health_check_path
    port                = "80"
    protocol            = "HTTP"
    matcher             = "200"
  }

  tags = var.tags_alb
}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_acm_certificate" "my_cert" {
  domain_name       = "dimabuapp.cloud"
  validation_method = "DNS"

  tags = {
    Name = "my_domain_certificate"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.my_cert.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  name    = each.value.name
  type    = each.value.type
  records = [each.value.value]
  ttl     = 60
  zone_id = var.zone_id
}

resource "aws_acm_certificate_validation" "my_cert_validation" {
  for_each            = aws_route53_record.cert_validation

  certificate_arn     = aws_acm_certificate.my_cert.arn
  validation_record_fqdns = [each.value.fqdn]

  depends_on = [aws_route53_record.cert_validation]
}


resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.my_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_route53_record" "alb_record" {
  zone_id = var.zone_id
  name    = "dimabuapp.cloud"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

