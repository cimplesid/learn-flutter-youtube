import 'package:cnnection/helpers/constants.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.signal_cellular_connected_no_internet_4_bar,
          size: 50,
        ),
        Text(
          'No internet connection',
          style: TEXT_STYLE2,
        )
      ],
    );
  }
}
