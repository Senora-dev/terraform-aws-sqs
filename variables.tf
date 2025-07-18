variable "name" {
  description = "The name of the queue"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "The prefix to use for the queue name"
  type        = string
  default     = null
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue in seconds"
  type        = number
  default     = 30
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message"
  type        = number
  default     = 345600 # 4 days
}

variable "max_message_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it"
  type        = number
  default     = 262144 # 256 KB
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed"
  type        = number
  default     = 0
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive"
  type        = number
  default     = 0
}

variable "policy" {
  description = "The JSON policy for the queue"
  type        = string
  default     = null
}

variable "redrive_policy" {
  description = "The JSON policy to set up the Dead Letter Queue"
  type        = string
  default     = null
}

variable "fifo_queue" {
  description = "Boolean designating a FIFO queue"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enables content-based deduplication for FIFO queues"
  type        = bool
  default     = false
}

variable "deduplication_scope" {
  description = "Specifies whether message deduplication occurs at the message group or queue level"
  type        = string
  default     = null
}

variable "fifo_throughput_limit" {
  description = "Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group ID"
  type        = string
  default     = null
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  type        = string
  default     = null
}

variable "kms_data_key_reuse_period_seconds" {
  description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again"
  type        = number
  default     = 300
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "create_queue_policy" {
  description = "Whether to create a queue policy"
  type        = bool
  default     = false
}

variable "queue_policy" {
  description = "The JSON policy for the queue"
  type        = string
  default     = null
}

variable "create_redrive_allow_policy" {
  description = "Whether to create a redrive allow policy"
  type        = bool
  default     = false
}

variable "redrive_allow_policy" {
  description = "The JSON policy to set up the Dead Letter Queue redrive allow policy"
  type        = string
  default     = null
}

variable "create_redrive_policy" {
  description = "Whether to create a redrive policy"
  type        = bool
  default     = false
} 