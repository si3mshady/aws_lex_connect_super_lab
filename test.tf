# provider "aws" {
#   region = "us-east-1"  # Change the region to your desired region
# }

# resource "aws_lex_bot" "greeting_bot" {
#   name               = "GreetingBot"
#   description        = "A simple greeting bot"
#   create_version     = true
#   enable_model_improvements = true
# }

# resource "aws_lex_bot_version" "greeting_bot_version" {
#   name             = aws_lex_bot.greeting_bot.name
#   bot_name         = aws_lex_bot.greeting_bot.name
#   checksum         = filebase64sha256("bot.json")  # Create this JSON file
#   process_behavior = "BUILD"
# }

# resource "aws_lex_intent" "greeting_intent" {
#   name                 = "GreetingIntent"
#   description          = "Intent for greeting users"
#   create_version       = true
#   bot_name             = aws_lex_bot.greeting_bot.name
#   sample_utterances    = ["Hello", "Hi", "Greetings"]
# }

# resource "aws_lex_intent_version" "greeting_intent_version" {
#   name         = aws_lex_intent.greeting_intent.name
#   bot_name     = aws_lex_bot.greeting_bot.name
#   intent_name  = aws_lex_intent.greeting_intent.name
#   checksum     = filebase64sha256("intent.json")  # Create this JSON file
#   process_behavior = "BUILD"
# }

# resource "aws_lex_bot_alias" "greeting_alias" {
#   name         = "Prod"
#   description  = "Production alias for the greeting bot"
#   bot_name     = aws_lex_bot.greeting_bot.name
#   bot_version  = aws_lex_bot_version.greeting_bot_version.name
# }

# output "bot_alias" {
#   value = aws_lex_bot_alias.greeting_alias.name
# }
