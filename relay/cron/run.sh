# usage: ./run.sh hubname
# eg., ./run.sh whitewhale

# functions
loop_forever () {
  echo "loop forever for debugging only"
  while true; do sleep 5; done
}

hubname="$1"
if [[ -z $hubname ]]; then
  echo "No hubname!"
  loop_forever
fi


pacman -Syu --noconfirm
pacman -S --noconfirm git base-devel python python-pip cronie screen wget jq

# get hermes config
eval "$(curl -s "https://raw.githubusercontent.com/oraichain/cosmosia/dev/relay/relayerhubs_registry.ini" |awk -v TARGET=$hubname -F ' = ' '
  {
    if ($0 ~ /^\[.*\]$/) {
      gsub(/^\[|\]$/, "", $0)
      SECTION=$0
    } else if (($2 != "") && (SECTION==TARGET)) {
      print $1 "=" $2
    }
  }
  ')"
echo "hermes_version=${hermes_version}"
if [[ -z $hermes_version ]]; then
  echo "No hermes_version!"
  loop_forever
fi

# write env vars to bash file, so that cronjobs or other scripts could know
cat <<EOT >> $HOME/env.sh
hubname="$hubname"
hermes_version="$hermes_version"
EOT

# install hermes (but dont run it)
cd $HOME
mkdir -p $HOME/.hermes/bin
wget -O - "https://github.com/informalsystems/hermes/releases/download/${hermes_version}/hermes-${hermes_version}-x86_64-unknown-linux-gnu.tar.gz" |tar -xz -C $HOME/.hermes/bin/

# hermes config
curl -Ls "http://tasks.web_config/config/cosmosia.relay_clear.${hubname}.mnemonic.txt" > $HOME/.hermes/mnemonic.txt
source <(curl -Ls -o- "https://raw.githubusercontent.com/oraichain/cosmosia/dev/relay/chains.sh")
curl -Ls "https://raw.githubusercontent.com/oraichain/cosmosia/dev/relay/${hubname}_config.toml" > $HOME/.hermes/config.toml.template
envsubst < $HOME/.hermes/config.toml.template > $HOME/.hermes/config.toml


chain_ids=$(cat $HOME/.hermes/config.toml |grep "id = " |sed -e "s/id = //g" -e "s/'//g" -e 's/"//g')
for chain_id in $chain_ids; do
  hd_path="m/44'/118'/0'/0/0" # default
  if [ $( echo "${chain_id}" | grep -cE "^(canto_7700-1)$" ) -ne 0 ]; then
    hd_path="m/44'/60'/0'/0/0"  # canto
  elif [ $( echo "${chain_id}" | grep -cE "^(kava_2222-10)$" ) -ne 0 ]; then
    hd_path="m/44'/459'/0'/0/0"  # kava
  fi
  $HOME/.hermes/bin/hermes keys add --hd-path "${hd_path}" --chain $chain_id --mnemonic-file $HOME/.hermes/mnemonic.txt
done

########################################################################################################################
# run the metrics server (for reporting wallet balances)
cd $HOME
<<<<<<< HEAD
git clone --single-branch --branch dev https://github.com/oraichain/cosmosia
=======
git clone --single-branch --branch main https://github.com/oraichain/cosmosia
<<<<<<< HEAD
>>>>>>> 2a95595 (first add)
=======
>>>>>>> f96366d (fix conflict)
>>>>>>> 055e1f6 (fix conflict)
cd cosmosia/relay/cron/metrics

pip install -r requirements.txt --break-system-packages
screen -S metrics -dm /usr/sbin/python main.py

########################################################################################################################
# cronjob

# cronjob clear packets
curl -Ls "https://raw.githubusercontent.com/oraichain/cosmosia/dev/relay/cron/cron_hermes_clear.sh" > $HOME/cron_hermes_clear.sh
echo "*/5 * * * * root /bin/bash $HOME/cron_hermes_clear.sh" > /etc/cron.d/cron_hermes_clear

# cronjob to update client
curl -Ls "https://raw.githubusercontent.com/oraichain/cosmosia/dev/relay/cron/cron_update_client.sh" > $HOME/cron_update_client.sh

echo "0 */1 * * * root /bin/bash $HOME/cron_update_client.sh" > /etc/cron.d/cron_update_client

crond
################################################################################################
loop_forever