provider "aws" {
  region = "us-east-1" # Set your desired AWS region


}


variable "bot_key" {
  type = string
  default = "v2BaseBot.zip"
}


variable "bot_bucket_name" {
    type = string
    default = "aws-connect-lex-labs"
}



variable "bucket_name" {
  type = string
  default = "terraform-state-mgmt-elliott"
}


terraform {
  backend "s3" {
    bucket = "terraform-state-mgmt-elliott"
    region = "us-east-1"
    key = "terraform-test.tfstate"
  }
}

resource "aws_cloudformation_stack" "lex_bot_cfn" {
  name = "LEXBOT2"
  template_body = file("lexbot_cfn_base.yml")
  capabilities = ["CAPABILITY_NAMED_IAM"]
  parameters = {
    BucketName = var.bucket_name
    BotBucketName = var.bot_bucket_name
    BotExport = var.bot_key
   
  }
  tags = {
    Environment = "Production"
  }
}


# resource "null_resource" "create-bot-locale" {
#   provisioner "local-exec" {
#     command = "aws lexv2-models create-bot-locale --bot-id ${var.bot_id} --bot-version ${var.bot_version} --locale-id ${var.bot_locale} --nlu-intent-confidence-threshold 0.4"
#   }
# }


# aws lexv2-models create-bot-locale --bot-id VD4IZSUGEQ --bot-version DRAFT --locale-id en_US --nlu-intent-confidence-threshold 0.4
