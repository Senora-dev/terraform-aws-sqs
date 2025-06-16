output "queue_url" {
  description = "The URL of the created Amazon SQS queue"
  value       = aws_sqs_queue.this.url
}

output "queue_arn" {
  description = "The ARN of the created Amazon SQS queue"
  value       = aws_sqs_queue.this.arn
}

output "queue_name" {
  description = "The name of the created Amazon SQS queue"
  value       = aws_sqs_queue.this.name
}

output "queue_id" {
  description = "The ID of the created Amazon SQS queue"
  value       = aws_sqs_queue.this.id
} 