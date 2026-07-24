
resource "aws_ecr_repository" "app_repository" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Environment      = var.environment
    GereParTerraform = "true"
    Formation        = "terraform seance1"
  }
}