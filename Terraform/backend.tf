terraform {
  backend "s3" {
    key            = "Terraform/terraform.tfstate"
    dynamodb_table = "terraform-locks"
    encrypt        = true

    # bucket et region ne sont pas configurables via variables ici.
    # Fournis-les au moment du init, par exemple :
    # terraform init -backend-config="bucket=<nom-du-bucket>" -backend-config="region=<region>"
  }
}
