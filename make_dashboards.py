import boto3
import json
# Create CloudWatch client
cloudwatch = boto3.client('cloudwatch')

# Define the alarms to include in the dashboard
alarm_names = ['MissedUtteranceCountAlarm','IntentCountAlarm','PositiveFeedbackCountAlarm', 'NegativeFeedbackCountAlarm', 'FulfilledRequestCountAlarm']

# Get the ARNs of the alarms
alarm_arns = []
for alarm_name in alarm_names:
    response = cloudwatch.describe_alarms(AlarmNames=[alarm_name])
    alarm_arns.append(response['MetricAlarms'][0]['AlarmArn'])

# Create the dashboard body
dashboard_body = {
    "widgets": [
        {
            "type": "alarm",
            "properties": {
                "title": "My Alarms",
                "alarms": alarm_arns
            }
        }
    ]
}

# Create the dashboard
response = cloudwatch.put_dashboard(
    DashboardName='MyDashboard',
    DashboardBody=json.dumps(dashboard_body)
)

print(response)
