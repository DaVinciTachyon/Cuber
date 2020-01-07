import 'package:flutter/material.dart';
import 'cube_timer.dart';

void main() => runApp(Cuber());

class Cuber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuber',
      home: Scaffold(
        body: CubeTimer(),
      ),
    );
  }
}
