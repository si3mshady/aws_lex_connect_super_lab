# import boto3

# # Create a client for the Amazon Lex V2 service
# lexv2_client = boto3.client('lexv2-models')

# # Define the "OrderFood" intent
# intent = {
#     'intentName': 'OrderFood',
#     'description': 'Intent for ordering food',
#     'sampleUtterances': [
#         {'utterance': 'I want to order a pizza'},
#         {'utterance': 'Can I order a burger?'}
#     ]
# }

# # Create the "OrderFood" intent
# response = lexv2_client.create_intent(
#     botId='VD4IZSUGEQ',
#     botVersion='DRAFT',
#     localeId='en_US',
#     intentName=intent['intentName'],
#     description=intent['description'],
#     sampleUtterances=intent['sampleUtterances']
# )

# # Print the response
# print(response)

import boto3

# Create a client for the Amazon Lex V2 service
lexv2_client = boto3.client('lexv2-models')

# Define the "OrderFood" intent
intent = {
    'intentName': 'OrderFood',
    'description': 'Intent for ordering food',
    'sampleUtterances': [
        {'utterance': 'I want to order a {FoodType}'},
        {'utterance': 'Can I order a {FoodType}?'}
    ],
    'slots': [
        {
            'slotName': 'FoodType',
            'description': 'The type of food to order',
            'slotType': 'MenuItems',
            'valueElicitationPrompt': {
                'messages': [
                    {
                        'contentType': 'PlainText',
                        'content': 'What would you like to order?'
                    }
                ],
                'maxAttempts': 2
            },
            'slotConstraint': 'Required'
        }
    ]
}

# Define the "MenuItems" slot type
slot_type = {
    'slotTypeName': 'MenuItems',
    'description': 'Types of menu items',
    'valueSelectionSetting': {
        'resolutionStrategy': 'OriginalValue'
    },
    'slotTypeValues': [
        {
            'sampleValue': {
                'value': 'Burger'
            }
        },
        {
            'sampleValue': {
                'value': 'Sandwich'
            }
        },
        {
            'sampleValue': {
                'value': 'Pizza'
            }
        }
    ]
}

# Create the "MenuItems" slot type
response = lexv2_client.create_slot_type(
    botId='MyLexBotId',
    botVersion='DRAFT',
    localeId='en_US',
    slotTypeName=slot_type['slotTypeName'],
    description=slot_type['description'],
    valueSelectionSetting=slot_type['valueSelectionSetting'],
    slotTypeValues=slot_type['slotTypeValues']
)

# Create the "OrderFood" intent
response = lexv2_client.create_intent(
    botId='MyLexBotId',
    botVersion='MyLexBotVersion',
    localeId='en_US',
    intentName=intent['intentName'],
    description=intent['description'],
    sampleUtterances=intent['sampleUtterances'],
    slots=intent['slots']
)

# Print the response
print(response)
