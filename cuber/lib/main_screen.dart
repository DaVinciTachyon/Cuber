import 'package:flutter/material.dart';
import 'timerScreens/includes/time.dart';
import 'timerScreens/inspection.dart';
import 'timerScreens/penalty.dart';
import 'timerScreens/timer.dart';

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
              bool inspected;
              inspected = await Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(
                    milliseconds: 0,
                  ),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secAnimation) {
                    return Inspection(
                      inspection: 2,
                    );
                  },
                ),
              );
              bool penalty = false;
              if (!inspected) {
                penalty = await Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(
                      milliseconds: 0,
                    ),
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secAnimation) {
                      return Penalty();
                    },
                  ),
                );
                if (!penalty) {
                  time = -1;
                  return;
                }
              }
              time = await Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(
                    milliseconds: 0,
                  ),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secAnimation) {
                    return CubeTimer(
                      penalty: penalty ? 2 : 0,
                    );
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
