rl_service_name="go_relayer"

# delete existing service
docker service rm $rl_service_name

# create new service
docker service create \
  --name $rl_service_name \
  --replicas 1 \
  --network bignet \
  --network net1 \
  --network net2 \
  --network net3 \
  --network net4 \
  --network net5 \
  --network net6 \
  --network net7 \
  --network net8 \
  --constraint 'node.hostname==orai01' \
  --mount type=bind,source=/root/.relayer,destination=/root/.relayer \
  --endpoint-mode dnsrr \
  --restart-condition none \
  amd64/golang:latest \
  /bin/bash -c \
  "curl -s https://raw.githubusercontent.com/oraichain/cosmosia/dev/go-relayer/run.sh > ~/run.sh && /bin/bash ~/run.sh"
