provider "aws" {
  region = "us-east-1"
}

# Create a Dead Letter Queue
module "dlq" {
  source = "../../"

  name = "my-dlq"
}

# Create the main queue with DLQ
module "sqs" {
  source = "../../"

  name = "my-queue"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600
  max_message_size          = 262144
  delay_seconds             = 0
  receive_wait_time_seconds = 0

  create_queue_policy = true
  queue_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = [
          "sqs:SendMessage"
        ]
        Resource = "*"
        Condition = {
          ArnLike = {
            "aws:SourceArn": "arn:aws:s3:::my-bucket"
          }
        }
      }
    ]
  })

  create_redrive_policy = true
  redrive_policy = jsonencode({
    deadLetterTargetArn = module.dlq.queue_arn
    maxReceiveCount     = 5
  })

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
} 