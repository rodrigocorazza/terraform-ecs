resource "aws_ecs_task_definition" "ecs_task_definition" {
  family             = "ecs-ead-task"
  network_mode       = "awsvpc"
  requires_compatibilities = ["EC2"]
  execution_role_arn = "arn:aws:iam::379780689865:role/ecsTaskExecutionRole"
  cpu                = 1024

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = "ead-ctr"
      image     = "379780689865.dkr.ecr.us-west-2.amazonaws.com/teste:latest"
      cpu       = 512
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    },
  ])
}