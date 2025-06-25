# AWS SQS Terraform Module

This Terraform module creates an Amazon SQS (Simple Queue Service) queue with optional policies and configurations.

## Features

- Create standard or FIFO queues
- Configure queue policies
- Set up Dead Letter Queues (DLQ)
- Configure message retention and visibility timeout
- Support for KMS encryption
- Tagging support

## Usage

### Basic Usage

```hcl
module "sqs" {
  source = "Senora-dev/sqs/aws"

  name = "my-queue"
}
```

### Complete Usage

```hcl
# Create a Dead Letter Queue
module "dlq" {
  source = "path/to/module"

  name = "my-dlq"
}

# Create the main queue with DLQ
module "sqs" {
  source = "path/to/module"

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
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the queue | string | null | no |
| name_prefix | The prefix to use for the queue name | string | null | no |
| visibility_timeout_seconds | The visibility timeout for the queue in seconds | number | 30 | no |
| message_retention_seconds | The number of seconds Amazon SQS retains a message | number | 345600 | no |
| max_message_size | The limit of how many bytes a message can contain before Amazon SQS rejects it | number | 262144 | no |
| delay_seconds | The time in seconds that the delivery of all messages in the queue will be delayed | number | 0 | no |
| receive_wait_time_seconds | The time for which a ReceiveMessage call will wait for a message to arrive | number | 0 | no |
| policy | The JSON policy for the queue | string | null | no |
| redrive_policy | The JSON policy to set up the Dead Letter Queue | string | null | no |
| fifo_queue | Boolean designating a FIFO queue | bool | false | no |
| content_based_deduplication | Enables content-based deduplication for FIFO queues | bool | false | no |
| deduplication_scope | Specifies whether message deduplication occurs at the message group or queue level | string | null | no |
| fifo_throughput_limit | Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group ID | string | null | no |
| kms_master_key_id | The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK | string | null | no |
| kms_data_key_reuse_period_seconds | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again | number | 300 | no |
| tags | A map of tags to add to all resources | map(string) | {} | no |
| create_queue_policy | Whether to create a queue policy | bool | false | no |
| queue_policy | The JSON policy for the queue | string | null | no |
| create_redrive_allow_policy | Whether to create a redrive allow policy | bool | false | no |
| redrive_allow_policy | The JSON policy to set up the Dead Letter Queue redrive allow policy | string | null | no |
| create_redrive_policy | Whether to create a redrive policy | bool | false | no |

## Outputs

| Name | Description |
|------|-------------|
| queue_url | The URL of the created Amazon SQS queue |
| queue_arn | The ARN of the created Amazon SQS queue |
| queue_name | The name of the created Amazon SQS queue |
| queue_id | The ID of the created Amazon SQS queue |

## Examples

- [Basic Example](examples/basic/main.tf) - Creates a simple SQS queue
- [Complete Example](examples/complete/main.tf) - Creates an SQS queue with policies and DLQ

## Notes

1. For FIFO queues, the queue name must end with `.fifo`
2. When using content-based deduplication, make sure to set `fifo_queue` to `true`
3. The `queue_policy` should be a valid JSON string containing the IAM policy
4. When using a DLQ, make sure to create the DLQ first and reference its ARN in the redrive policy

## License

MIT Licensed. See LICENSE for full details. 

## Maintainers

This module is maintained by [Senora.dev](https://senora.dev). 