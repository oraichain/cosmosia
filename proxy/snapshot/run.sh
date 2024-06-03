# functions
loop_forever () {
  echo "loop forever for debugging only"
  while true; do sleep 5; done
}

cd $HOME
pacman -Syu --noconfirm
pacman -Sy --noconfirm nginx

echo "#################################################################################################################"
echo "nginx..."

curl -Ls "https://raw.githubusercontent.com/oraichain/cosmosia/dev/proxy/snapshot/nginx.conf" > /etc/nginx/nginx.conf
/usr/sbin/nginx

loop_forever