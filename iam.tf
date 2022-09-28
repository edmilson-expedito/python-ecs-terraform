data "aws_iam_policy_document" "assume_by_ecs" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "aws_iam_ecs_role" {
  name                = "${var.app_name}-${var.env_name}-execution_role"
  assume_role_policy  = data.aws_iam_policy_document.assume_by_ecs.json
  managed_policy_arns = [
    "arn:aws:iam::279726348302:role/yandeh-yhub-cross"
  ]
  tags = {
    Name        = "${var.app_name}-${var.env_name}-execution_role"
    Environment = local.app_environment
    Application = var.app_name
  }
}

resource "aws_iam_role_policy" "sts_liberacao" {
  name = "${var.app_name}-${var.env_name}-sts-liberacao"
  role = aws_iam_role.aws_iam_ecs_role.id
  policy = templatefile("policies/sts-liberacao.json")
}