resource "aws_codecommit_repository" "main" {
  repository_name = var.reponame
  description     = "CodeCommit repo: ${var.reponame}"
  default_branch  = "master"
}

resource "aws_codecommit_trigger" "main" {
  repository_name = aws_codecommit_repository.main.repository_name

  trigger {
    name            = "notifications"
    events          = ["all"]
    destination_arn = aws_sns_topic.main.arn
  }

  trigger {
    name            = "email"
    events          = ["all"]
    destination_arn = var.email-sns-arn
  }
}

