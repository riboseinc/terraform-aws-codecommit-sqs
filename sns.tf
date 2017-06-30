resource "aws_sns_topic" "main" {
  provider = "aws.regional"
  name = "codecommit-${var.reponame}-topic"
  display_name = "Ribose CodeCommit ${var.reponame} notifications"
}

resource "aws_sns_topic_policy" "main" {
  provider = "aws.regional"
  arn = "${aws_sns_topic.main.arn}"
  policy = "${data.aws_iam_policy_document.sns-policy.json}"
}

resource "aws_sqs_queue" "main" {
  provider = "aws.regional"
  name = "codecommit-${var.reponame}-notifications-queue"
  delay_seconds = 90
  max_message_size = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

resource "aws_sqs_queue_policy" "sns" {
  provider = "aws.regional"
  queue_url = "${aws_sqs_queue.main.id}"
  policy = "${data.aws_iam_policy_document.sns-sqs-policy.json}"
}

resource "aws_sns_topic_subscription" "sqs" {
  provider = "aws.regional"
  topic_arn = "${aws_sns_topic.main.arn}"
  endpoint = "${aws_sqs_queue.main.arn}"
  raw_message_delivery = "true"
  protocol = "sqs"
}

output "sqs-id" {
  value = "${aws_sqs_queue.main.id}"
}

output "sqs-arn" {
  value = "${aws_sqs_queue.main.arn}"
}

output "sns-name" {
  value = "${aws_sns_topic.main.name}"
}

output "sns-arn" {
  value = "${aws_sns_topic.main.arn}"
}

