# cosmosia (Cosmos Infrastructure Automation)

Open solution to build a reliable infrastructure for cosmos/tendermint based chains ( see [background](https://github.com/cosmos/chain-registry/issues/214) ):
- API service: Load balancing for Rpc, Rest, Websocket, [GRPC](docs/grpc.md) and JSON-RPC with active-healthcheck, rate-limiting and ip-whitelist.
- Daily [snapshot service](https://snapshot.notional.ventures/) for goleveldb and [rocksdb](/docs/rocksdb.md)
- Monitoring tools for both [internal](docs/rpc_monitor.md) and [external](https://status.notional.ventures/) view.
- Auto [pruning](https://github.com/notional-labs/cosmprund) and rpc service with snapshot/data versioning

See [status page](https://status.notional.ventures/) of our cluster.

### Supported chains:
| No  | Chain | [Statesync](docs/statesync.md) | [RocksDB](docs/rocksdb.md)
|:--- |:------|:------------------------------:|:-------------------------:|
| 1. | Osmosis (osmosis) | :x: | 
| 2. | Starname (starname) | :x: | 
| 3. | Regen (regen) | :white_check_mark: | :warning:
| 4. | Akash (akash) | :white_check_mark: | :white_check_mark:
| 5. | Gaia (cosmoshub) | :white_check_mark: | :white_check_mark:
| 6. | Sentinel (sentinel) | :white_check_mark: | :white_check_mark:
| 7. | E-Money (emoney) | :white_check_mark: | :white_check_mark:
| 8. | Ixo (ixo) | :white_check_mark: | :white_check_mark:
| 9. | Juno (juno) | :x: | 
| 10. | Sifchain (sifchain) | :white_check_mark: | :white_check_mark:
| 11. | Likecoin (likecoin) | :white_check_mark: | :white_check_mark:
| 12. | Ki (kichain) | :white_check_mark: | :white_check_mark:
| 13. | Cyber (cyber) | :x: | 
| 14. | Cheqd (cheqd) | :x: | 
| 15. | Stargaze (stargaze) | :x: | 
| 16. | Band (bandchain) | :white_check_mark: | :white_check_mark:
| 17. | Chihuahua (chihuahua) | :white_check_mark: | :white_check_mark:
| 18. | Kava (kava) | :white_check_mark: | :white_check_mark:
| 19. | BitCanna (bitcanna) | :white_check_mark: | :white_check_mark:
| 20. | Konstellation (konstellation) | :white_check_mark: | :white_check_mark:
| 21. | Omniflix (omniflixhub) | :white_check_mark: | :white_check_mark:
| 22. | Terra (terra) | :x: | 
| 23. | Vidulum (vidulum) | :white_check_mark: | :white_check_mark:
| 24. | Provenance (provenance) | :white_check_mark: | :white_check_mark:
| 25. | Dig (dig) | :white_check_mark: | :white_check_mark:
| 26. | Gravity-Bridge (gravitybridge) |:white_check_mark: | :white_check_mark:  
| 27. | Comdex (comdex) | :white_check_mark: | :white_check_mark:
| 28. | Cerberus (cerberus) | :white_check_mark: | :white_check_mark:
| 29. | BitSong (bitsong) | :white_check_mark: | :white_check_mark:
| 30. | ~~AssetMantle (assetmantle)~~ | :white_check_mark: | :white_check_mark: 
| 31. | FetchAI (fetchhub) | :x: | 
| 32. | Evmos (evmos) | :white_check_mark: | :white_check_mark: 
| 33. | Persistence (persistent) | :white_check_mark: | :warning:
| 34. | Crypto.org (cryptoorgchain) | :white_check_mark: | :white_check_mark:
| 35. | IRISnet (irisnet) | :white_check_mark: | :white_check_mark:
| 36. | Axelar (axelar) | :white_check_mark: | :warning:
| 37. | Pylons Testnet (pylons) | :white_check_mark: | 
| 38. | Umee (umee) | :white_check_mark: | 
| 39. | Sei-Chain Testnet (sei) |  | 



Add a new chain? Follow this [guide](docs/new_chain.md)

### Docs
See [Docs](./docs/)
