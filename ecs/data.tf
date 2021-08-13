data "aws_region" "this" {}

data "aws_ecr_image" "this" {
  repository_name = aws_ecr_repository.this.name
  image_tag = "latest"
}
