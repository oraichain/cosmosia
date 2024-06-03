#!/bin/bash

SERVICE_NAME="napi_dbbackup"

# delete existing service
docker service rm $SERVICE_NAME

echo "sleep 10s..."
sleep 10

# create new service
docker service create \
  --name $SERVICE_NAME \
  --replicas 1 \
  --network notionalapi \
  --constraint 'node.hostname==cosmosia21' \
  --endpoint-mode dnsrr \
  --restart-condition none \
  --mount type=bind,source=/mnt/data/napi_dbbackup,destination=/data \
  archlinux:latest \
  /bin/bash -c \
  "curl -s https://raw.githubusercontent.com/oraichain/cosmosia/dev/notionalapi/db_backup/run.sh > ~/run.sh && /bin/bash ~/run.sh"
