resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "${var.app_name}-${var.env_name}-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Name        = "${var.app_name}-${var.env_name}-ecs-cluster"
    Environment = local.app_environment
    Application = var.app_name
  }
}

resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "${var.app_name}-${var.env_name}-ecs-service"
  cluster              = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition      = aws_ecs_task_definition.aws-ecs-service.arn
  iam_role             = aws_iam_role.aws_iam_ecs_role.arn
  depends_on           = [aws_iam_role_policy.iam-ecs-role]
  load_balancer {
    target_group_arn = aws_lb_target_group.target_group[0].arn
    container_name   = "${var.app_name}-${var.env_name}-container"
    container_port   = var.container_port
  }
}