#!/bin/bash
set -e

# Replace this with your actual Discord webhook URL
WEBHOOK_URL="https://discord.com/api/webhooks/1403045301484519575/E1tijtZ1tnIL9cdspWRB7AQ8lNBusZ_uDfNfmX7GHQgJyMmdlHuQJXytDisg39WCM4tN"

# Message payload
JSON_PAYLOAD='{
  "content": "✅ file was used!"
}'

# Send the webhook
curl -H "Content-Type: application/json" -X POST -d "$JSON_PAYLOAD" "$WEBHOOK_URL"

echo "test done."
