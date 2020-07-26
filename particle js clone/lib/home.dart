import 'package:flutter/material.dart';
import 'package:partice/particle_canvas.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:html' as html;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xff0F752E),
        body: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: <Widget>[
            Center(
              child: ParticleCanvas(height: size.height, width: size.width),
            ),
            centerCard()
          ],
        ));
  }

  centerCard() {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black45,
          ),
          height: 300,
          width: 300,
          child: Column(
            children: <Widget>[
              SizedBox(height: 26),
              Text(
                'Particle js Clone',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 26),
              Text(
                'Made in flutter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 46),
              RaisedButton.icon(
                  color: Colors.black,
                  highlightColor: Colors.green,
                  onPressed: () {
                    html.window.open(
                        'https://github.com/cimplesid/learn-flutter-youtube',
                        "git");
                  },
                  icon: Icon(MdiIcons.github),
                  textColor: Colors.white,
                  label: Text('Github repo'))
            ],
          )),
    );
  }
}
