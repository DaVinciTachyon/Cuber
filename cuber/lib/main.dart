import 'package:flutter/material.dart';
import 'main_screen.dart';

void main() => runApp(Cuber());

class Cuber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuber',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
        errorColor: Colors.redAccent,
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
          ),
          display1: TextStyle(
            color: Colors.black,
            fontSize: 60.0,
          ),
          button: TextStyle(
            color: Colors.black,
            fontSize: 40.0,
            backgroundColor: Colors.redAccent,
          ),
        ),
      ),
      home: ResultScreen(),
    );
  }
}
