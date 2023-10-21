import boto3
import json

# Create a client for the Amazon Lex Model Building Service
client = boto3.client('lex-models')

# Specify the name of the intent you want to retrieve the checksum for
intent_name = 'myName'


# Get the intent
response = client.get_intent(
    name=intent_name,
    version='$LATEST'
)

# Get the checksum
checksum = response['checksum']
print(checksum)
# Define the response card
response_card = {
    "version": 1,
    "contentType": "application/vnd.amazonaws.card.generic",
    "genericAttachments": [
        {
            "title": "MyName Bot",
            "subTitle": "Please select your name",
            "buttons": [
                {
                    "text": "John",
                    "value": "John"
                },
                {
                    "text": "Jane",
                    "value": "Jane"
                },
                {
                    "text": "Bob",
                    "value": "Bob"
                }
            ]
        }
    ]
}

# Define the fulfillment activity
fulfillment_activity = {
    "type": "ReturnIntent"
}

# Create or update the intent with the fulfillment activity
# response = client.put_slot_type(
#     name='OrderFood',
#     enumerationValues=[
#         {
#             'value': 'burger'
#         },
#         {
#             'value': 'pizza'
#         },
#         {
#             'value': 'pasta'
#         },
#         {
#             'value': 'salad'
#         }
#     ]
# )
# slot_type_version = response['version']

# response = client.get_slot_type(
#     name='OrderFood',
#     version='$LATEST'
# )

# # Get the checksum
# checksum = response['checksum']


# Define the intent with the custom slot type and slot type version
response = client.put_intent(
    name='myName',
    sampleUtterances=[
        'Hello and Salutations',
        'Hi',
        'Greetings'
    ],
    slots=[
        {
            "name": "Name",
            "description": "What is your name",
            "priority": 1,
            "slotConstraint": "Required",
            "slotType": "AMAZON.AlphaNumeric",
            "valueElicitationPrompt": {
                "maxAttempts": 2,
                "messages": [
                    {
                        "contentType": "PlainText",
                        "content": "Hey may I have your name"
                    }
                ]
            },
            "sampleUtterances": [
                "My name is {Name}"
            ]
        }
    ],
    fulfillmentActivity={
        "type": "ReturnIntent"
    },
    checksum=checksum
)



print(response)