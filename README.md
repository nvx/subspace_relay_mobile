# Subspace Relay Mobile

<a href="https://play.google.com/store/apps/details?id=io.nv.subspacerelay.mobile" alt="Get it on Google Play"><img src="https://raw.githubusercontent.com/pioug/google-play-badges/refs/heads/main/svg/en.svg" height="70"></a>

Mobile app that implements a [Subspace Relay](https://github.com/nvx/subspace-relay) on Android.

Currently supports relay mode with Android HCE and as a reader.

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

### Parameters
* `tls` set to `false` to disable tls
* `discovery` set to 64 hex bytes of X25519 public key to enable discovery, or empty to clear out the pubkey. If omitted the discovery public key will not be changed
* `websocket` set to true to use a websocket connection
* `path` set if a path component is required for websocket connections
* `name` display name for this connection; used as the label for saved favorites and for connections opened from history or deep links
