#!/bin/bash
set -e

IP=$1
DOMAIN=$2

curl -X POST "https://api.cloudflare.com/client/v4/zones/${CF_ZONE_ID}/dns_records" \
  -H "Authorization: Bearer ${CLOUDFLARE_TOKEN}" \
  -H "Content-Type: application/json" \
  --data "{\"type\":\"A\",\"name\":\"*.${DOMAIN}\",\"content\":\"${IP}\",\"ttl\":3600,\"proxied\":false}"

echo "Created DNS record for *.${DOMAIN} → ${IP}"