resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  versioning {
    enabled = var.enable_versioning
  }
  tags = var.tags
}
