import 'package:flutter/material.dart';
import 'timer.dart';
import 'penalty.dart';

class Inspection extends StatefulWidget {
  final int inspection;

  Inspection({this.inspection = 15});

  @override
  _InspectionTimer createState() => _InspectionTimer(this.inspection);
}

class _InspectionTimer extends State<Inspection> with TickerProviderStateMixin {
  AnimationController controller;
  int _inspection;

  _InspectionTimer(this._inspection);

  int get timerString {
    Duration duration = controller.value == 0
        ? controller.duration
        : controller.duration * controller.value;
    int d = duration.inSeconds % 60;
    return d;
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: _inspection,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox.expand(
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Theme.of(context).accentColor,
                      height: controller.value == 0
                          ? MediaQuery.of(context).size.height
                          : controller.value *
                              MediaQuery.of(context).size.height,
                    ),
                  ),
                  SizedBox.expand(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return FlatButton(
                          child: Text(
                            "$timerString",
                            style: Theme.of(context).primaryTextTheme.display1,
                          ),
                          onPressed: () async {
                            if (controller.isAnimating) {
                              controller.stop();
                              Navigator.pop(context, true);
                            } else {
                              controller.reverse(
                                from: 1.0,
                              );
                              controller.addListener(() async {
                                if (controller.value == 0)
                                  Navigator.pop(context, false);
                              });
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
