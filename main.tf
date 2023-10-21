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

#  intent {
#     intent_name = aws_lex_intent.order_food.name
#     intent_version = "$LATEST"
#   }
  
}


resource "aws_lex_intent" "myname" {
  name = "myName"
  description = "Intent used to capture user information"
  create_version = false

  sample_utterances = [
    "Hello and Salutations",
    "Hi",
    "Greetings"
  ]

  confirmation_prompt {
    max_attempts = 2

    message {
      content_type = "PlainText"
      content = "Nice to meet you {Name}"
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
    description = "What is your name"
    priority = 1
    slot_constraint = "Required"
    slot_type = "AMAZON.AlphaNumeric"

    sample_utterances = [
        "My name is {Name}"
    ]

    value_elicitation_prompt {
      max_attempts = 2

      message {
        content_type = "PlainText"
        content = "Hey may I have your name"
      }
    }
  }
#   response_card = jsonencode({
#     version = 1,
#     contentType = "application/vnd.amazonaws.card.generic",
#     genericAttachments = [
#       {
#         title = "MyName Bot",
#         subTitle = "Please select your name",
#         buttons = [
#           {
#             text = "John",
#             value = "John"
#           },
#           {
#             text = "Jane",
#             value = "Jane"
#           },
#           {
#             text = "Bob",
#             value = "Bob"
#           }
#         ]
#       }
#     ]
#   })
}


#######

# resource "aws_lex_intent" "order_food" {
#   name = "OrderFood"
#   description = "Intent to order food from a restaurant"
#   create_version = false

#   sample_utterances = [
#     "I want to order food.",
#     "Can I get some food from your restaurant.",
#     "I'd like to place an order for delivery.",
#     "What's on the menu today.",
#     "How can I place an order for takeout.",
#     "I'm hungry. What can I order.",
#     "Do you have any specials for today.",
#     "I need to order some food for pickup.",
#     "Tell me about your food options.",
#     "I'm looking to get some food delivered."
#   ]

#   confirmation_prompt {
#     max_attempts = 2

#     message {
#       content_type = "PlainText"
#       content = "Absolutely, I'm thrilled to tell you about our delightful menu! Get ready for a mouthwatering experience with our incredible selection, including juicy burgers, heavenly pizzas, flavorful pastas, fresh and crisp salads, delectable sandwiches, and exquisite sushi."
      
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
#     name = "OrderItems"
#     slot_type_version = "$LATEST"
#     description = "The items to be ordered"
#     priority = 1
#     slot_constraint = "Optional"
#     slot_type = aws_lex_slot_type.menu.name

#     # sample_utterances = ["I want to order a {OrderItems}"]

    


#     value_elicitation_prompt {
#       max_attempts = 2

     
#       message {
#         content_type = "PlainText"
#         content = "Great so you want to order {OrderItems}, correct."
        
#       }
#     }

   
#   }

  


#    }





# resource "aws_lex_slot_type" "menu" {
#   description = "Enumeration representing possible food items on the menu"
#   create_version = false

#   enumeration_value {
#     value = "burger"
#   }

#   enumeration_value {
#     value = "pizza"
#   }

#   enumeration_value {
#     value = "pasta"
#   }

#   enumeration_value {
#     value = "salad"
#   }

#   enumeration_value {
#     value = "sandwich"
#   }

#   enumeration_value {
#     value = "sushi"
#   }

#   name                     = "FoodItems"
#   value_selection_strategy = "ORIGINAL_VALUE"
# }


