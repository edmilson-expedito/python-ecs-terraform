resource "aws_ecr_repository" "ecr_repo_python" {
  name = "${var.app_name}-${var.env_name}-repo" # "nb2b-rds-kinesis-dev-repo"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name        = "${var.app_name}-${var.env_name}-repo"
    Environment = local.app_environment
    Application = var.app_name
  }
}