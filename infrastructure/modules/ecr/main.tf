resource "aws_ecr_repository" "image_registry" {
  name = var.repository_name
  image_tag_mutability = var.repository_image_tag_mutability
  force_delete = var.repository_force_delete

  encryption_configuration {
    encryption_type = var.repository_encryption_type
  }

  image_scanning_configuration {
    scan_on_push = var.repository_image_scan_on_push
  }
}

resource "aws_ecr_lifecycle_policy" "policy_count_more_than" {
  count = var.expired_after == -1 ? 1 : 0
  repository = aws_ecr_repository.image_registry.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description = "Keep images until count is more than",
        selection = {
          tagStatus = "any",
          countType = "imageCountMoreThan",
          countNumber = var.max_image_count
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_lifecycle_policy" "policy_expired_after" {
  count = var.expired_after == -1 ? 0 : 1
  repository = aws_ecr_repository.image_registry.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description = "Keep images until count is more than",
        selection = {
          tagStatus = "any",
          countType = "sinceImagePushed",
          countUnit = "days",
          countNumber = var.expired_after
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}
