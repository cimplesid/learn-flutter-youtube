import 'package:http/http.dart' as http;

class ApiHelper {
  getCoins() async {
    var data = await http.get('https://api.coinlore.net/api/tickers/');
    print(data.body);
  }
}

final apiHelper = ApiHelper();
