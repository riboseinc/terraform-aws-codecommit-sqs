resource "aws_sns_topic" "main" {
  name         = "${var.topic-prefix}${var.reponame}${var.topic-suffix}"
  display_name = "CodeCommit ${var.reponame} notifications"
}

resource "aws_sns_topic_policy" "main" {
  arn    = aws_sns_topic.main.arn
  policy = data.aws_iam_policy_document.sns-policy.json
}

resource "aws_sns_topic_subscription" "sqs" {
  topic_arn            = aws_sns_topic.main.arn
  endpoint             = var.sqs-arn
  raw_message_delivery = "true"
  protocol             = "sqs"
}

output "sns-name" {
  value = aws_sns_topic.main.name
}

output "sns-arn" {
  value = aws_sns_topic.main.arn
}

