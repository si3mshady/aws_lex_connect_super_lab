#!/bin/bash

BOT_ID="$1"

BOT_VERSION="$2"

LOCALE_ID="$3"

# Call the create-bot-locale command
aws lexv2-models create-bot-locale \
    --bot-id "${BOT_ID}" \
    --bot-version "${BOT_VERSION}" \
    --locale-id "${LOCALE_ID}" \
    --nlu-intent-confidence-threshold 0.4