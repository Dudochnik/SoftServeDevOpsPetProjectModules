resource "aws_ecr_repository" "this" {
  name = var.repository_name
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "role-name"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role" "ecs_task_role" {
  name = "role-name-task"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "task_s3" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.task_family_name
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = var.network_mode
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  requires_compatibilities = var.requires_compatibilities
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = "${data.aws_ecr_image.this.registry_id}.dkr.ecr.${data.aws_region.this.name}.amazonaws.com/${aws_ecr_repository.this.name}:${data.aws_ecr_image.this.image_tag}"
    }
  ])
}

resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
}

resource "aws_ecs_service" "this" {
  name = var.service_name
  cluster = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count = 1
  launch_type = var.launch_type
  network_configuration {
    subnets = var.subnets
    security_groups = var.security_groups
    assign_public_ip = true
  }
}