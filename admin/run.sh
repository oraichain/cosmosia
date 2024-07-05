pacman -Syu --noconfirm
pacman -S --noconfirm base-devel jq dnsutils git yarn cronie screen python docker


# install nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

nvm install v18.14.0

yarn set version v18.14.0

cd $HOME
git clone --single-branch --branch dev https://github.com/oraichain/cosmosia
<<<<<<< HEAD
=======
git clone --single-branch --branch main https://github.com/oraichain/cosmosia
<<<<<<< HEAD
>>>>>>> 2a95595 (first add)
=======
>>>>>>> f96366d (fix conflict)
>>>>>>> 055e1f6 (fix conflict)
=======
>>>>>>> 504abb2 (change config)

# create env.sh for cosmosia
cat <<EOT >> $HOME/cosmosia/env.sh
CHAIN_REGISTRY_INI_URL=$CHAIN_REGISTRY_INI_URL
USE_SNAPSHOT_PROXY_URL=$USE_SNAPSHOT_PROXY_URL
USE_DOMAIN_NAME=$USE_DOMAIN_NAME
COSMOSIA_ADMIN_NEXTAUTH_URL=$COSMOSIA_ADMIN_NEXTAUTH_URL
COSMOSIA_ADMIN_NEXTAUTH_SECRET=$COSMOSIA_ADMIN_NEXTAUTH_SECRET
COSMOSIA_ADMIN_PASSWORD=$COSMOSIA_ADMIN_PASSWORD
EOT

########################################################################################################################
# web
cd $HOME/cosmosia/admin/web

# create .env.local file
cat <<EOT >> .env.local
NEXTAUTH_URL="$COSMOSIA_ADMIN_NEXTAUTH_URL"
NEXTAUTH_SECRET="$COSMOSIA_ADMIN_NEXTAUTH_SECRET"
NEXT_PUBLIC_USE_DOMAIN_NAME="$USE_DOMAIN_NAME"
ADMIN_PASSWORD="$COSMOSIA_ADMIN_PASSWORD"
CHAIN_REGISTRY_INI_URL="$CHAIN_REGISTRY_INI_URL"
EOT


yarn && yarn build

screen -S server -dm yarn start

########################################################################################################################
# cron
echo "*/1 * * * * root /bin/bash $HOME/cosmosia/admin/cronjob_get_status.sh" > /etc/cron.d/cron_get_status
echo "*/1 * * * * root /bin/bash $HOME/cosmosia/admin/cronjob_get_val_status.sh" > /etc/cron.d/cronjob_get_val_status
#echo "*/5 * * * * root /bin/bash $HOME/cosmosia/admin/cronjob_get_snapshot_size.sh" > /etc/cron.d/cron_get_snapshot_size

# start crond
crond

# loop forever for debugging only
while true; do sleep 5; done
