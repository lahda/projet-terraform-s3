resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name != "" ? var.bucket_name : "tf-s3-${random_id.suffix.hex}"
  acl    = "private"

  tags = merge(var.tags, {
    Name = var.bucket_name != "" ? var.bucket_name : "tf-s3-${random_id.suffix.hex}"
  })
}
