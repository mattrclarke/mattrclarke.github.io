require 'HTTParty'
# require 'oauth2'
require 'awesome_print'
require 'byebug'
# require 'faye/websocket'
# require 'eventmachine'

#-----------------TEST KEYS --------------------------
nab_client_id = "27147d3b-ce90-4465-9daf-b3a8ee488ced"
coinapi_key = "73034021-0EBC-493D-8A00-E0F138111F41"
#______________________________________________________________

#---------------------------NAB-------------------------------

nab_sandbox_endpoint = "https://sandbox.api.nab/v2/fxrates?v=1"
nab_accounts_endpoint = "https://sandbox.api.nab/v2/accounts?v=1"
nab_endpoint = "https://developer.nab.com.au/common/oauth-registration?scope=accounts&client_id=[#client_id]&redirect_uri=[YOUR REDIRECT URI]"
#  response = HTTParty.get('https://sandbox.api.nab/v2/fxrates?v=1',{
#   headers:  {'x-nab-key' => '27147d3b-ce90-4465-9daf-b3a8ee488ced', 'User-Agent' => 'Httparty'}
# })
#______________________________________________________________




#---------------------COINAPI-------------------------------
exchanges_endpoint      = "https://rest.coinapi.io/v1/exchanges"
symbols_endpoint        = "https://rest.coinapi.io/v1/symbols"
assets_endpoint         = "https://rest.coinapi.io/v1/assets"
btc_price               = "https://rest.coinapi.io/v1/exchangerate/BTC"
aaa = "https://rest.coinapi.io/v1/quotes/BITSTAMP_SPOT_BTC_USD/history?time_start=2016-01-01T00:00:00"
orderbooks              = "https://rest.coinapi.io/v1/orderbooks/current"
websocket_endpoint            = "wss://ws.coinapi.io/v1/"

header = {'X-CoinAPI-Key' => coinapi_key, 'User-Agent' => 'Httparty'}

ws_header = {
  "type": "hello",
  "apikey": coinapi_key,
  "heartbeat": false,
  "subscribe_data_type": ["trade"],
  "subscribe_filter_symbol_id": [
    "BITSTAMP_SPOT_BTC_USD",
    "BITFINEX_SPOT_BTC_LTC",
    "COINBASE_",
    "ITBIT_"
    ]
}
# response = HTTParty.get(all_exchanges_endpoint, headers: header)
response = HTTParty.get(assets_endpoint, headers: header)
#______________________________________________________________

parsed = JSON.parse(response.body)
byebug
ap parsed