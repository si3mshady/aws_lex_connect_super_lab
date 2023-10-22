provider "aws" {
  region = "us-east-1" # Set your desired AWS region


}

terraform {
  backend "s3" {
    bucket = "terraform-state-mgmt-elliott"
    region = "us-east-1"
    key = "terraform-test.tfstate"
  }
}

resource "aws_iam_role" "lex_bot_role" {
  name = "LexBotRoleV2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lexv2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lex_bot_policy" {
  name = "LexBotPolicyV2"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lexv2:CreateBot",
          "lexv2:DeleteBot",
          "lexv2:DescribeBot",
          "lexv2:UpdateBot",
          "lexv2:CreateBotAlias",
          "lexv2:DeleteBotAlias",
          "lexv2:DescribeBotAlias",
          "lexv2:UpdateBotAlias",
          "lexv2:CreateBotLocale",
          "lexv2:DeleteBotLocale",
          "lexv2:DescribeBotLocale",
          "lexv2:UpdateBotLocale",
          "lexv2:CreateIntent",
          "lexv2:DeleteIntent",
          "lexv2:DescribeIntent",
          "lexv2:UpdateIntent",
          "lexv2:CreateSlot",
          "lexv2:DeleteSlot",
          "lexv2:DescribeSlot",
          "lexv2:UpdateSlot"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lex_bot_policy_attachment" {
  policy_arn = aws_iam_policy.lex_bot_policy.arn
  role = aws_iam_role.lex_bot_role.name
}


resource "null_resource" "create-endpoint" {
  provisioner "local-exec" {
    command = "aws lexv2-models create-bot --bot-name elliottLexBot --role-arn arn:aws:iam::335055665325:role/LexBotRoleV2 --data-privacy true --cli-input-json file://bot.json>"
  }
}

output "LexBotRoleArn" {
  value = aws_iam_role.lex_bot_role.arn
}
