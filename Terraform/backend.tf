terraform {
  backend "s3" {
    key          = "Terraform/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
    region       = "us-east-1"

    # bucket et region ne sont pas configurables via variables ici.
    # Fournis-les au moment du init, par exemple :
    # terraform init -backend-config="bucket=<nom-du-bucket>" -backend-config="region=<region>"
  }
}
