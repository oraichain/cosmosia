# delete existing service
docker service rm proxy_static

# create new service
docker service create \
  --name proxy_static \
  --replicas 1 \
  --publish mode=host,target=80,published=80 \
  --publish mode=host,target=443,published=443 \
  --publish mode=host,target=9090,published=9090 \
  --publish mode=host,target=1317,published=1317 \
  --publish mode=host,target=26657,published=26657 \
  --network bignet \
  --network cosmosia \
  --network snapshot \
  --constraint 'node.hostname==orai01' \
  --sysctl 'net.ipv4.tcp_tw_reuse=1' \
  --restart-condition none \
  --env-file ../../env.sh \
  archlinux:latest \
  /bin/bash -c \
  "curl -s https://raw.githubusercontent.com/oraichain/cosmosia/dev/proxy/static/run.sh > ~/run.sh && /bin/bash ~/run.sh"
