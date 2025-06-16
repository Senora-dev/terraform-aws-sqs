resource "aws_sqs_queue" "this" {
  name                        = var.name
  name_prefix                 = var.name_prefix
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  message_retention_seconds   = var.message_retention_seconds
  max_message_size           = var.max_message_size
  delay_seconds              = var.delay_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  policy                     = var.policy
  redrive_policy             = var.redrive_policy
  fifo_queue                 = var.fifo_queue
  content_based_deduplication = var.content_based_deduplication
  deduplication_scope        = var.deduplication_scope
  fifo_throughput_limit      = var.fifo_throughput_limit
  kms_master_key_id          = var.kms_master_key_id
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds
  tags                       = var.tags
}

resource "aws_sqs_queue_policy" "this" {
  count  = var.create_queue_policy ? 1 : 0
  queue_url = aws_sqs_queue.this.url
  policy    = var.queue_policy
}

resource "aws_sqs_queue_redrive_allow_policy" "this" {
  count  = var.create_redrive_allow_policy ? 1 : 0
  queue_url = aws_sqs_queue.this.url
  redrive_allow_policy = var.redrive_allow_policy
}

resource "aws_sqs_queue_redrive_policy" "this" {
  count  = var.create_redrive_policy ? 1 : 0
  queue_url = aws_sqs_queue.this.url
  redrive_policy = var.redrive_policy
} 