resource "random_id" "suffix" {
    byte_length = 4
}

# Use the s3 module located at ./s3. Pass the bucket name (or generate one)
module "s3" {
    source = "./s3"

    aws_s3_bucket = var.bucket_name
    aws_region    = var.aws_region
}

module "ecr" {
    source = "./ecr"
    aws_region            = var.aws_region
    ecr_repository_name   = var.ecr_repository_name
    environment           = var.environment  
}
