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

 intent {
    intent_name = aws_lex_intent.order_food.name
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
    # slot_type_version = "$LATEST" No version when using bui
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
}


#######

resource "aws_lex_intent" "order_food" {
  name = "OrderFood"
  description = "Intent to order food from a restaurant"
  create_version = false

  sample_utterances = [
    "I want to order food."
    # "Can I get some food from your restaurant.",
    # "I'd like to place an order for delivery.",
    # "What's on the menu today.",
    # "How can I place an order for takeout.",
    # "I'm hungry. What can I order.",
    # "Do you have any specials for today.",
    # "I need to order some food for pickup.",
    # "Tell me about your food options.",
    # "I'm looking to get some food delivered."
  ]

  

  confirmation_prompt {
    max_attempts = 2

    message {
      content_type = "PlainText"
      content = "Absolutely, I'm thrilled to tell you about our delightful menu! Get ready for a mouthwatering experience with our incredible selection, including juicy burgers, heavenly pizzas, flavorful pastas, fresh and crisp salads, delectable sandwiches, and exquisite sushi."
      
    }

    message {
      content_type = "PlainText"
      content = "Great so you want to order {OrderItems}, correct."
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
    name = "OrderItems"
    slot_type_version = "$LATEST"
    description = "The items to be ordered"
    priority = 1
    slot_constraint = "Optional"
    slot_type = aws_lex_slot_type.menu.name

    sample_utterances = ["I want to order a {OrderItems}"]

    


    value_elicitation_prompt {
      max_attempts = 2

     
      message {
        content_type = "PlainText"
        content = "Great so you want to order {OrderItems}, correct."
        
      }
    }

   
  }

  


   }





resource "aws_lex_slot_type" "menu" {
  description = "Enumeration representing possible food items on the menu"
  create_version = false

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

