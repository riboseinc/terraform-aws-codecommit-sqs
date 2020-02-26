# SNS Email module
# data "template_file" "cloudformation_sns_stack" {
#   template = "${file("${path.module}/../tf_sns_email/templates/email-sns-stack.json.tpl")}"
#
#   vars {
#     topic_name    = "${var.codecommit-email-email-name}"
#     display_name  = "${var.codecommit-email-email-name}"
#     email_address = "${var.sns-emails}"
#     protocol    = "email"
#   }
# }
#
# resource "aws_cloudformation_stack" "codecommit-email-sns-topic" {
#   name = "${var.codecommit-email-sns-stack-name}"
#   template_body = "${data.template_file.cloudformation_sns_stack.rendered}"
#
#   tags {
#     Owner = "${var.codecommit-email-email-name}"
#   }
# }
# output "sns-email-arn" {
#   value = "${data.template_file.cloudformation_sns_stack..outputs["ARN"]}}"
# }
