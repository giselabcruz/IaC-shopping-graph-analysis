module "sqs" {
  source     = "../modules/sqs"
  queue_name = "s3-event-notification-queue"
  tags = {
    Environment = "dev"
    Project     = "shopping-graph"
  }
}
