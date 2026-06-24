resource "aws_s3_bucket" "mon_bucket" {
    bucket = var.aws_s3_bucket
}

resource "aws_s3_bucket_versioning" "mon_bucket_versioning" {
    bucket = aws_s3_bucket.mon_bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}