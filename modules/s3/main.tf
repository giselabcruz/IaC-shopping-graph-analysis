resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  versioning {
    enabled = var.enable_versioning
  }
  tags = var.tags
}

# S3 bucket notification to SQS
resource "aws_s3_bucket_notification" "bucket_notification" {
  count  = var.enable_sqs_notification ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id

  queue {
    queue_arn     = var.sqs_queue_arn
    events        = var.notification_events
    filter_prefix = var.notification_filter_prefix
    filter_suffix = var.notification_filter_suffix
  }
}
