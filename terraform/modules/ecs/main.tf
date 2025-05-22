data "aws_caller_identity" "current" {}

resource "aws_ecs_cluster" "this" {
  name = "devops-demo-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "devops-demo-cluster"
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "secrets_manager_policy" {
  name = "secrets_manager_policy"
  role = aws_iam_role.ecs_task_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = [
          "arn:aws:secretsmanager:${var.aws_region}:${data.aws_caller_identity.current.account_id}:secret:*"
        ]
      }
    ]
  })
}

resource "aws_ecs_task_definition" "php_app" {
  family                   = "devops-demo-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn           = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "php-app"
      image     = var.image_url
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ],
      environment = [
        { name = "DB_NAME", value = var.db_name },
        { name = "ENV_NAME", value = var.env_name },
        { name = "DB_HOST", value = var.db_host },
        { name = "DB_USER", value = var.db_username }
      ],
      secrets = [
        {
          name      = "DB_PASSWORD"
          valueFrom = var.db_password_arn
        }
      ],
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:80/ || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 60
      },
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/devops-demo-task"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
          awslogs-create-group  = "true"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "php_service" {
  name            = "devops-demo-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.php_app.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs_tasks.id]
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "php-app"
    container_port   = 80
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_execution_policy,
    aws_iam_role_policy.secrets_manager_policy
  ]
}

resource "aws_security_group" "ecs_tasks" {
  name        = "ecs-tasks-sg"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id] # Allow from itself (or modify per your LB/SG)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-tasks-sg"
  }
}
