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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
          child: Text(
            "Cube Timer",
            style: Theme.of(context).primaryTextTheme.title,
          ),
        ),
      ),
      body: Center(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              time == -1 ? "DNF" : timeFormat(time, 3),
              style: Theme.of(context).primaryTextTheme.display1,
            ),
          ),
          FlatButton(
            child: Text(
              "Timer",
              style: Theme.of(context).primaryTextTheme.button,
            ),
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
