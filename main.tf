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

resource "aws_lex_bot" "devbot" {
  name = "DevBot"
  description = "DevBot"
  create_version = false
  locale = "en-US"
  

  abort_statement {
    message {
      content_type = "PlainText"
      content = "Sorry, I am not able to assist at this time"
    }
  }

  child_directed = false

  clarification_prompt {
    max_attempts = 2
    message {
      content_type = "PlainText"
      content = "I didn't understand you, may I know your name"
    }
  }

  idle_session_ttl_in_seconds = 600
  process_behavior = "BUILD"
  voice_id = "Salli"

  intent {
    intent_name = aws_lex_intent.myname.name
    intent_version = "$LATEST"
  }

  
}

resource "aws_lex_intent" "myname" {
  name = "myName"
  description = "Intent used to capture user information"
  create_version = false


  sample_utterances = [
    "Hello and Salutations",
    "Hi",
    "Greetings"
    # "Hey there My name is Robo. What is your name",
    # "Greetings. My name is Robo. What's your name",
    # "Good day I am Robo. What is your name",
    # "Welcome I'm Robo. What's your name",
    # "Hello it's Robo here. What's your name",
    # "Hey I'm Robo. What is your name",
    # "Hi there. My name is Robo. What's your name",
    # "Hello this is Robo. What is your name"
]

  confirmation_prompt {
    max_attempts = 2

    message {
      content_type = "PlainText"
      content = "Nice to meet you {myName}"
      
    }
  }

  rejection_statement {
    message {
      content_type = "PlainText"
      content = "I'm sorry, I cannot assist you at this time."
    }
  }

  fulfillment_activity {
    type = "ReturnIntent"
  }

  slot {
    name = "Name"
    # slot_type_version = "$LATEST" No version when using bui
    description = "What is your name"
    priority = 1
    slot_constraint = "Required"
    slot_type = "AMAZON.AlphaNumeric"

    sample_utterances = [
    "Hello my name is {myName} ",
    "Hi there my name is {myName}"
   
]

   
    value_elicitation_prompt {
      max_attempts = 2

      message {
        content_type = "PlainText"
        content = "Hey may I have your name"
      }
    }
    
  }
}
