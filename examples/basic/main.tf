provider "aws" {
  region = "us-east-1"
}

module "sqs" {
  source = "../../"

  name = "my-basic-queue"
} 