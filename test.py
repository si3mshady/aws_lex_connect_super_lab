# import boto3
# import json

# # Create a client for the Amazon Lex Model Building Service
# client = boto3.client('lex-models')

# # Specify the name of the intent you want to retrieve the checksum for
# intent_name = 'OrderFood'


# # Get the intent
# response = client.get_intent(
#     name=intent_name,
#     version='$LATEST'
# )

# # Get the checksum
# checksum = response['checksum']
# print(checksum)
# # Define the response card
# response_card = {
#     "version": 1,
#     "content": [
#         {
#             "contentType": "application/vnd.amazonaws.card.generic",
#             "genericAttachments": [
#                 {
#                     "title": "Food Items",
#                     "subTitle": "On the menu",
#                     "buttons": [
#                         {
#                             "text": "Burger",
#                             "value": "burger"
#                         },
#                         {
#                             "text": "Pizza",
#                             "value": "pizza"
#                         },
#                         {
#                             "text": "Pasta",
#                             "value": "pasta"
#                         },
#                         {
#                             "text": "Salad",
#                             "value": "salad"
#                         }
#                     ]
#                 }
#             ]
#         }
#     ]
# }

# # Define the fulfillment activity
# fulfillment_activity = {
#     "type": "ReturnIntent"
# }

# # Create or update the intent with the fulfillment activity
# # response = client.put_slot_type(
# #     name='OrderFood',
# #     enumerationValues=[
# #         {
# #             'value': 'burger'
# #         },
# #         {
# #             'value': 'pizza'
# #         },
# #         {
# #             'value': 'pasta'
# #         },
# #         {
# #             'value': 'salad'
# #         }
# #     ]
# # )
# # slot_type_version = response['version']

# # response = client.get_slot_type(
# #     name='OrderFood',
# #     version='$LATEST'
# # )

# # # Get the checksum
# # checksum = response['checksum']


# # Define the intent with the custom slot type and slot type version
# response = client.put_intent(
#     name='OrderFood',
#     sampleUtterances=[
#         'I want to order food.',
#         'Can I get some food from your restaurant.',
#         'I\'d like to place an order for delivery.'
#     ],
#     slots=[
#         {
#             "name": "OrderItems",
#             "slotType": "MenuOptions",
#             "slotTypeVersion": "$LATEST",
#             "slotConstraint": "Optional",
#             "valueElicitationPrompt": {
#                 "messages": [
#                     {
#                         "contentType": "PlainText",
#                         "content": "What food items would you like to order?"
#                     }
#                 ],
#                 "maxAttempts": 2
#             },
#         }
#     ],
#     fulfillmentActivity={
#         "type": "ReturnIntent"
#     },
#     checksum=checksum
# )



# print(response)