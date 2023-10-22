import boto3

# Create a client for the Amazon Lex V2 service
lexv2_client = boto3.client('lexv2-models')

# Define the "OrderFood" intent
intent = {
    'intentName': 'OrderFoodV2',
    'description': 'Intent for ordering food',
    'sampleUtterances': [
        {'utterance': 'I want to order a pizza'},
        {'utterance': 'Can I order a burger?'}
    ]
}

# Create the "OrderFood" intent
response = lexv2_client.create_intent(
   botId='VD4IZSUGEQ',
    botVersion='DRAFT',
    localeId='en_US',
    intentName=intent['intentName'],
    description=intent['description'],
    sampleUtterances=intent['sampleUtterances']
)

# Print the response
print(response)
