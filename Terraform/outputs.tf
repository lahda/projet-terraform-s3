output "bucket_arn" {
    description = "ARN de mon bucket deja cree"
    value = aws_s3_bucket.eazy_bucket_demo339713069769.arn  
}

output "bucket_id" {
    description = "ID de mon bucket deja cree"
    value = aws_s3_bucket.eazy_bucket_demo339713069769.id
}