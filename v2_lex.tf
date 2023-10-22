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

resource "aws_cloudformation_stack" "lex_bot_cfn" {
  name = "LexV2"
  template_body = file("lexbot_cfn_base.yml")
  tags = {
    Environment = "Production"
  }
}