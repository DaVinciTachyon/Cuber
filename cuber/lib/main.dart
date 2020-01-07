import 'package:flutter/material.dart';
import 'main_screen.dart';

void main() => runApp(Cuber());

class Cuber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuber',
      home: ResultScreen(),
    );
  }
}
