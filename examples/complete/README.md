# Complete SQS Example

This example demonstrates the complete usage of the SQS module to create a main queue with a Dead Letter Queue (DLQ), custom queue policy, and redrive policy.

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Requirements

| Name      | Version |
|-----------|---------|
| terraform | >= 1.0  |
| aws       | >= 4.0  |

## Providers

| Name | Version |
|------|---------|
| aws  | >= 4.0  |

## Resources Created

This example will create:

* An SQS Dead Letter Queue (DLQ)
* An SQS main queue with:
  * Custom queue policy (allowing S3 to send messages)
  * Redrive policy referencing the DLQ
  * Custom visibility timeout, retention, and other settings
  * Tags for environment and project

## Inputs

All values are pre-configured in the `main.tf` file for this example. See the module's documentation for all available variables.

## Outputs

| Name      | Description                        |
|-----------|------------------------------------|
| queue_url | The URL of the created SQS queue   |
| queue_arn | The ARN of the created SQS queue   |
| queue_name| The name of the created SQS queue  |
| queue_id  | The ID of the created SQS queue    |

---

*This example is maintained by Senora.dev.* 