import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pagination/models/coin.dart';

class ApiHelper {
  getCoins() async {
    var data = await http.get('https://api.coinlore.net/api/tickers/');
    return Coin.fromMap(json.decode(data.body));
  }
}

final apiHelper = ApiHelper();
