
SERVICE_NAME="napi_apicount_pruner"

# delete existing service
docker service rm $SERVICE_NAME

# create new service
docker service create \
  --name $SERVICE_NAME \
  --replicas 1 \
  --network bignet \
  --network notionalapi \
  --constraint 'node.hostname==cosmosia21' \
  --endpoint-mode dnsrr \
  --restart-condition none \
  archlinux:latest \
  /bin/bash -c \
  "curl -s https://raw.githubusercontent.com/oraichain/cosmosia/dev/notionalapi/apicount_pruner/run.sh > ~/run.sh && /bin/bash ~/run.sh"
