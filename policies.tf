data "aws_iam_policy_document" "sns-policy" {
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

# AWS syntax:
# {
#   "Version": "2008-10-17",
#   "Id": "__default_policy_ID",
#   "Statement": [
#     {
#       "Sid": "__default_statement_ID",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "*"
#       },
#       "Action": [
#         "SNS:GetTopicAttributes",
#         "SNS:SetTopicAttributes",
#         "SNS:AddPermission",
#         "SNS:RemovePermission",
#         "SNS:DeleteTopic",
#         "SNS:Subscribe",
#         "SNS:ListSubscriptionsByTopic",
#         "SNS:Publish",
#         "SNS:Receive"
#       ],
#       "Resource": "arn:aws:sns:us-east-1:${var.aws-account-id}:test-topic",
#       "Condition": {
#         "StringEquals": {
#           "AWS:SourceOwner": "${var.aws-account-id}"
#         }
#       }
#     }
#   ]
# }

  # SNS Email subscription
  #
  # statement {
  #   effect = "Allow"
  #   principals {
  #     type = "AWS"
  #     identifiers = [ "*" ]
  #   }
  #   actions = [
  #     "SNS:Subscribe",
  #     "SNS:Receive"
  #   ]
  #   resources = [ "${aws_sns_topic.main.arn}" ]
  #   condition {
  #     test = "StringLike"
  #     variable = "SNS:Endpoint"
  #     values = [ "@${var.email-domain-name}" ]
  #   }
  #   condition {
  #     test = "StringEquals"
  #     variable = "SNS:Protocol"
  #     values = [ "email" ]
  #   }
  # }
}

