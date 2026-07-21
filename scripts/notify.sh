#!/bin/bash
# Send system notification using environment variable
if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "Error: AWS_ACCESS_KEY_ID environment variable is not set."
  exit 1
fi

echo "Notification service initialized successfully."
