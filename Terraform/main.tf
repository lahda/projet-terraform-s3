resource "aws_s3_bucket" "eazy_bucket_demo339713069769" {
    bucket = "terraform-bucket-339713069769"
}

resource "aws_s3_bucket_versioning" "eazy_bucket_demo339713069769_versioning" {
    bucket = aws_s3_bucket.eazy_bucket_demo339713069769.id
    versioning_configuration {
        status = "Enabled"
    }
}