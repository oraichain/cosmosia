cd $HOME

if [[ -z $upgrading ]]; then
  git clone --single-branch --branch $version $git_repo
  repo_name=$(basename $git_repo |cut -d. -f1)
  cd $repo_name
else
  repo_name=$(basename $git_repo |cut -d. -f1)
  cd $repo_name
  git reset --hard
  git fetch --all --tags
  git checkout "$p_version"
fi

go mod edit -replace github.com/tendermint/tm-db=github.com/oraichain/tm-db@v0.11.0
go mod tidy
go install -tags pebbledb -ldflags "-w -s -X github.com/cosmos/cosmos-sdk/types.DBBackend=pebbledb" ./...