resource "aws_db_subnet_group" "main" {
  name       = "devops-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "devops-db-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-access"
  description = "Allow ECS access to RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with ECS SG for tighter security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_db_instance" "postgres" {
  identifier              = "devops-demo-db"
  engine                  = "postgres"
  engine_version          = "15.3"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp2"
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  multi_az                = true
  publicly_accessible     = false
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.main.name

  tags = {
    Name = "devops-demo-db"
  }
}
