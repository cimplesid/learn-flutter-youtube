import 'package:flutter/material.dart';

import 'helper/api_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    apiHelper.getCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('coin'),
      ),
      body: ListView.builder(itemBuilder: (c,i){

      },
      ),
    );
  }
}
