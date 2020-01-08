import 'package:flutter/material.dart';
import 'timerScreens/includes/time.dart';
import 'timerScreens/inspection.dart';

class ResultScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ResultScreenState();
  }
}

class ResultScreenState extends State<ResultScreen> {
  int time = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Cube Timer"),
        ),
      ),
      body: Center(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              timeFormat(time, 3),
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ),
          FlatButton(
            child: Text("Timer"),
            onPressed: () async {
              time = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Inspection();
                  },
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
