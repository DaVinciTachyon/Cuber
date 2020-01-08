import 'package:flutter/material.dart';
import 'timer.dart';

class Inspection extends StatefulWidget {
  @override
  _InspectionTimer createState() => _InspectionTimer();
}

class _InspectionTimer extends State<Inspection> with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.value == 0
        ? controller.duration
        : controller.duration * controller.value;
    return '${duration.inSeconds % 60}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.amber,
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
                            timerString,
                            style: TextStyle(fontSize: 50),
                          ),
                          onPressed: () async {
                            if (controller.isAnimating) {
                              controller.stop();
                              Navigator.pop(
                                context,
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CubeTimer();
                                    },
                                  ),
                                ),
                              );
                            } else {
                              controller.reverse(
                                from: 1.0,
                              );
                              controller.addListener(() {
                                if (controller.value == 0)
                                  Navigator.pop(context, -1);
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
