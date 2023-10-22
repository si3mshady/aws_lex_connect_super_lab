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

#   intent {
#     intent_name = aws_lex_intent.myname.name
#     intent_version = "$LATEST"
#   }

 intent {
    intent_name = aws_lex_intent.order_food.name
    intent_version = "$LATEST"
  }
  
}



# resource "aws_lex_intent" "myname" {
#   name = "myName"
#   description = "Intent used to capture user information"
#   create_version = false


#   sample_utterances = [
#     "Hello and Salutations",
#     "Hi",
#     "Greetings"
#     # "Hey there My name is Robo. What is your name",
#     # "Greetings. My name is Robo. What's your name",
#     # "Good day I am Robo. What is your name",
#     # "Welcome I'm Robo. What's your name",
#     # "Hello it's Robo here. What's your name",
#     # "Hey I'm Robo. What is your name",
#     # "Hi there. My name is Robo. What's your name",
#     # "Hello this is Robo. What is your name"
# ]

    

#   confirmation_prompt {
#     max_attempts = 2

#     message {
#       content_type = "PlainText"
#       content = "Nice to meet you {Name}"
      
#     }
#   }
  

  

#   rejection_statement {
#     message {
#       content_type = "PlainText"
#       content = "I'm sorry, I cannot assist you at this time."
#     }
#   }

#   fulfillment_activity {
#     type = "ReturnIntent"
#   }

#   slot {
#     name = "Name"
#     # slot_type_version = "$LATEST" No version when using bui
#     description = "What is your name"
#     priority = 1
#     slot_constraint = "Required"
#     slot_type = "AMAZON.AlphaNumeric"

#     sample_utterances = [
#         "My name is {Name}"
   
# ]


   
#     value_elicitation_prompt {
#       max_attempts = 2

#       message {
#         content_type = "PlainText"
#         content = "Hey may I have your name"
#       }
#     }
    
#   }
# }


#######

resource "aws_lex_intent" "order_food" {
  name = "OrderFood"
  description = "Intent to order food from a restaurant"
  create_version = false

   sample_utterances = [
    "Hello",
    "Hi",
    "How are you",
    "What's up",
    "Good morning",
    "Good afternoon",
    "Good evening"
  ]

  depends_on = [ aws_lambda_function.test_lambda ]
  
  fulfillment_activity {
    type = "CodeHook"
    code_hook {
      uri = aws_lambda_function.test_lambda.arn
      message_version = "1.0"
    }
  }

  confirmation_prompt {
    max_attempts = 2

    message {
      group_number = 1
      content_type = "PlainText"
      content = "Absolutely, I'm thrilled to tell you about our delightful menu! Get ready for a mouthwatering experience with our incredible selection, including juicy burgers, heavenly pizzas, flavorful pastas, fresh and crisp salads, delectable sandwiches, and exquisite sushi."
      
    }

    message {
    
      content_type = "PlainText"
      content = "Great so you want to order food {OrderItem}, correct."
    }

    
   

  }
  
  

  rejection_statement {
    message {
      content_type = "PlainText"
      content = "I'm sorry, I cannot assist you at this time."
    }
  }

  
  

  slot {
    name = "OrderItems"
    slot_type_version = "$LATEST"
    description = "The items to be ordered"
    priority = 1
    slot_constraint = "Optional"
    slot_type = aws_lex_slot_type.menu.name

    sample_utterances = [
        "I want to order a {OrderItems}"
    
    
    ]

    


    value_elicitation_prompt {
      max_attempts = 2

     
      message {
        content_type = "PlainText"
        content = "What do you want to order"
        
      }
    }

   
  }

  


   }





resource "aws_lex_slot_type" "menu" {
  description = "Enumeration representing possible food items on the menu"
  create_version = true

  enumeration_value {
    value = "burger"
  }

  enumeration_value {
    value = "pizza"
  }

  enumeration_value {
    value = "pasta"
  }

  enumeration_value {
    value = "salad"
  }

  enumeration_value {
    value = "sandwich"
  }

  enumeration_value {
    value = "sushi"
  }

  name                     = "FoodItems"
  value_selection_strategy = "ORIGINAL_VALUE"
}




# data "archive_file" "lambda" {
#   type        = "zip"
#   source_file = "lambda.js"
#   output_path = "lambda_function_payload.zip"
# }


resource "aws_iam_role" "lambda_role" {
  name = "LambdaRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  role = aws_iam_role.lambda_role.name
}

resource "aws_iam_policy" "lambda_policy" {
  name = "LambdaPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "lex_integration"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_handler.lambda_handler"

#   source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.8"

  
}

resource "aws_lambda_permission" "food_items_lambda_permission" {
  statement_id  = "AllowExecutionFromLex"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "lex.amazonaws.com"
}