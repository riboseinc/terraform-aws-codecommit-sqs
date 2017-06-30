data "aws_iam_policy_document" "sns-policy" {
  provider = "aws.regional"
  policy_id = "__default_policy_ID"
  statement {
    sid = "AllowSubscriptionFromSQS"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [ "*" ]
    }
    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive"
    ]
    resources = [ "${aws_sns_topic.main.arn}" ]
    condition {
      test = "StringEquals"
      variable = "AWS:SourceOwner"
      values = [ "${var.aws-account-id}" ]
    }
  }

}

data "aws_iam_policy_document" "sns-sqs-policy" {
  provider = "aws.regional"
  policy_id = "arn:aws:sqs:${var.aws-region}:${var.aws-account-id}:testing/SQSDefaultPolicy"

  statement {
    sid = "SubscribeToSNS"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [ "*" ]
    }
    actions = [ "SQS:SendMessage" ]
    resources = [ "${aws_sqs_queue.main.arn}" ]
    condition {
      test = "ArnEquals"
      variable = "aws:SourceArn"
      values = [ "${aws_sns_topic.main.arn}" ]
    }
  }
}

