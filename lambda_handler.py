import json

def lambda_handler(event, context):
    food_items = ["Burger", "Pizza", "Pasta", "Salad", "Sandwich", "Sushi"]
    
    response = {
        "sessionAttributes": {},
        "dialogAction": {
            "type": "Close",
            "fulfillmentState": "Fulfilled",
            "message": {
                "contentType": "PlainText",
                "content": "Here are the available food items: " + ", ".join(food_items)
            }
        }
    }
    
    return response