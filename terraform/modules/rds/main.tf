resource "aws_db_subnet_group" "main" {
  name       = "devops-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name        = "devops-db-subnet-group"
    Environment = var.environment
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Security group for RDS MySQL instance"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "rds-security-group"
    Environment = var.environment
  }
}

resource "aws_security_group_rule" "rds_inbound" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = var.ecs_security_group_id
  security_group_id        = aws_security_group.rds_sg.id
  description              = "Allow inbound MySQL access from ECS tasks"
}

resource "aws_security_group_rule" "rds_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_sg.id
  description       = "Allow all outbound traffic"
}

resource "aws_db_instance" "mysql" {
  identifier                = "devops-demo-db-${lower(var.environment)}"
  engine                    = "mysql"
  engine_version            = "8.0"
  instance_class            = "db.t3.micro"
  allocated_storage         = 20
  storage_type              = "gp3"
  username                  = var.db_username
  password                  = var.db_password
  db_name                   = var.db_name
  multi_az                  = var.environment == "Prod" ? true : false
  publicly_accessible       = false
  skip_final_snapshot       = var.environment != "Prod"
  final_snapshot_identifier = var.environment == "Prod" ? "devops-demo-final-snapshot" : null
  vpc_security_group_ids    = [aws_security_group.rds_sg.id]
  db_subnet_group_name      = aws_db_subnet_group.main.name
  backup_retention_period   = var.environment == "Prod" ? 7 : 1
  deletion_protection       = var.environment == "Prod"

  tags = {
    Name        = "devops-demo-db"
    Environment = var.environment
  }
}
