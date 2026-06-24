output "bucket_arn" {
    description = "ARN de mon bucket deja cree"
    value = aws_s3_bucket.mon_bucket.arn
}

output "bucket_id" {
    description = "ID de mon bucket deja cree"
    value = aws_s3_bucket.mon_bucket.id
}