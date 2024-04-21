
resource "aws_db_instance" "default" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  identifier             = var.db_identifier
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = var.parameter_group_name
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true
  multi_az               = var.multi_az

  
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.db_identifier}-subnet-group"
  subnet_ids = var.subnet_ids
}


resource "aws_security_group" "db_sg" {
  name        = "${var.db_identifier}-sg"
  description = "Managed by Terraform for RDS instance"
  vpc_id      = var.vpc_id


  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
