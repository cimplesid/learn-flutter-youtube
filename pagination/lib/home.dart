import 'package:flutter/material.dart';
import 'package:pagination/models/coin.dart';

import 'helper/api_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Coin coin;
  @override
  void initState() {
    super.initState();
    getCoin();
  }

  getCoin() async {
    coin = await apiHelper.getCoins();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('coin'),
        ),
        body: getBody());
  }

  getBody() {
    if (coin == null) return Center(child: CircularProgressIndicator());
    return ListView.builder(
      itemBuilder: (c, i) {
        return Card(
          elevation: 2,
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Text('${i + 1}'),
            title: Text(coin.data[i].name),
            trailing: Text("\$" + coin.data[i].priceUsd),
          ),
        );
      },
      itemCount: coin.data.length,
    );
  }
}
