# Subspace Relay Mobile

## App deep links

Overall format: `subspace-relay://[user[:pass]@]mqtt-server-host[:port][/start-mode][?parameters]`

For example to set the broker to `mqtts://user:pass@example.com` and start HCE mode use
`subspace-relay://user:pass@example.com/card`

To instead use websockets to connect to `wss://user:pass@example.com/mqtt` and start reader mode use
`subspace-relay://user:pass@example.com/reader?path=/mqtt&websocket=true`

### Start modes

* `/card` start HCE
* `/reader` start Reader
* `/reader-dynamic` start Reader Dynamic

### Paramaters
* `tls` set to `false` to disable tls
* `discovery` set to 64 hex bytes of X25519 public key to enable discovery, or empty to clear out the pubkey. If omitted the discovery public key will not be changed
* `websocket` set to true to use a websocket connection
* `path` set if a path component is required for websocket connections
tls=false&discovery=pubkey&websocket=true&path=/mqtt
