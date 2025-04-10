# Terraform module for ECR
This module creates a private ECR repository application and environment.
## Available features
- AWS ECR repository
- Lifecycle policy
## Set up
- Just use an AWS account with IAM role like:
  AmazonEC2ContainerRegistryFullAccess
- Import the module
```terraform
module "ecr" {
  source = "../../modules/ecr"
  repository_name = "my-testing-ecr"
}
```

## How to use it
### With defaule lifecycle policy, this will set the default lifecycle policy to keep 5 images in the repository
```terraform
module "ecr" {
  source = "../../modules/ecr"
  repository_name = "my-testing-ecr"
}
```
### With lifecycle count more than:
```terraform
module "ecr" {
  source = "../../modules/ecr"
  repository_name = "my-testing-ecr"
  max_image_count = 14
}
```
### With lifecycle expired after:
```terraform
module "ecr" {
  source = "../../modules/ecr"
  repository_name = "my-testing-ecr"
  expired_after = 14
}
```
## Customization
| Variable                | Type          | Required                   | Default Value |
|---|---|----------------------------|---------------|
| `repository_name`         | string        | yes                        |               |
| `repository_image_tag_mutability` | string        | no                         | `MUTABLE`     |
| `repository_encryption_type`  | string        | no                         | null          |
| `repository_kms_key`       | string        | no                         | null          |
| `repository_image_scan_on_push` | bool          | no                         | false         |
| `repository_policy`        | string        | no                         | null          |
| `repository_force_delete`   | bool          | no                         | null          |
| `max_image_count`           | number        | no                         | 5             |
| `expired_after`             | number        | if not use max image count | -1            |


