variable "reponame" {}
variable "aws-account-id" {}

# Can enable if an email notification is desired.
variable "email-sns-arn" {}

# SQS queue to publish to
variable "sqs-arn" {}
variable "sqs-id" {}

variable "topic-prefix" { default = "codecommit-" }
variable "topic-suffix" { default = "-topic" }

