import boto3
import json

# Create a client for the Amazon Lex Model Building Service
client = boto3.client('lex-models')

# Define the response card
response_card = {
    "version": 1,
    "content": [
        {
            "contentType": "application/vnd.amazonaws.card.generic",
            "genericAttachments": [
                {
                    "title": "Food Items",
                    "subTitle": "On the menu",
                    "buttons": [
                        {
                            "text": "Burger",
                            "value": "burger"
                        },
                        {
                            "text": "Pizza",
                            "value": "pizza"
                        },
                        {
                            "text": "Pasta",
                            "value": "pasta"
                        },
                        {
                            "text": "Salad",
                            "value": "salad"
                        }
                    ]
                }
            ]
        }
    ]
}

# Create or update the intent with the response card
response = client.put_intent(
    name='OrderFood',
    slots=[
        {
            "name": "OrderItems",
            "slotConstraint": "Optional",  # Required slotConstraint
            "valueElicitationPrompt": {
                "messages": [
                    {
                        "contentType": "PlainText",
                        "content": "What food items would you like to order?"
                    }
                ],
                "maxAttempts": 2  # Required maxAttempts
            },
        }
    ]
)

print(response)  # Optional: Print the response for verification
