import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const bitcoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker';
// 
class CoinData {
  Future<List<Map>> Getdata(String selectedCurrency) async {
    List<Map> Prices = [];
    for(String crypto in cryptoList){
       String requestURL = '$bitcoinAverageURL/$crypto$selectedCurrency';
       print(requestURL);
        http.Response response = await http.get(requestURL);

        Map Price = jsonDecode(response.body);
        print(Price);
        Prices.add(Price);
    }
    print('DONE');
   return Prices;
   
  }
}
