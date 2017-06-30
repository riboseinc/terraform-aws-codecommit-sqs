# Using the us-east-1 region for CodeCommit
variable "aws-region" { default = "us-east-1" }

variable "reponame" {}
variable "aws-account-id" {}

# Can enable if an email notification is desired.
variable "email-sns-arn" {}

