provider "aws" {
  region = "us-east-1" # Set your desired AWS region


}

variable "bot_id" {
  type = string
  default = "VD4IZSUGEQ"
}

variable "bot_description" {
  type = string
  default = "My Amazon Lex V2 bot"
}

variable "bot_locale" {
  type = string
  default = "en_US"
}

variable "bot_version" {
  type = string
  default = "DRAFT"
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
  name = "LexV2"
  template_body = file("lexbot_cfn_base.yml")
  capabilities = ["CAPABILITY_NAMED_IAM"]
  parameters = {
    BucketName = var.bucket_name
   
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

# aws lexv2-models create-bot-locale --bot-id VD4IZSUGEQ --bot-version DRAFT --locale-id en_US --nlu-intent-confidence-threshold 0.4

# aws lexv2-models create-bot-locale --bot-id ${var.bot_name} --bot-version ${var.bot_version} --locale-id en_US --nlu-intent-confidence-threshold 0.4 

# aws lexv2-models create-bot-locale --bot-id VD4IZSUGEQ --bot-version DRAFT --locale-id en_US --nlu-intent-confidence-threshold 0.4 --voice-settings {\"voiceId\":\"Celine\",\"voiceName\":\"Celine\"}'