import 'package:flutter/material.dart';
import 'package:partice/particle_canvas.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: ParticleCanvas(
        height: size.height,
        width: size.width,
      ),
    );
  }
}
