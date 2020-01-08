import 'package:flutter/material.dart';
import 'timer.dart';

class Inspection extends StatefulWidget {
  final int inspectionPenalty;
  final int inspection;

  Inspection({this.inspection = 15, this.inspectionPenalty = 2});

  @override
  _InspectionTimer createState() =>
      _InspectionTimer(this.inspection, this.inspectionPenalty);
}

class _InspectionTimer extends State<Inspection> with TickerProviderStateMixin {
  AnimationController controller;
  int _inspectionPenalty;
  int _inspection;

  _InspectionTimer(this._inspection, this._inspectionPenalty);

  int get timerString {
    Duration duration = controller.value == 0
        ? controller.duration
        : controller.duration * controller.value;
    int d = duration.inSeconds % 60;
    return d >= _inspectionPenalty ? d - _inspectionPenalty : 0;
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _inspection + _inspectionPenalty),
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
                            "$timerString",
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
                                      return CubeTimer(
                                        penalty: timerString == 0
                                            ? _inspectionPenalty
                                            : 0,
                                      );
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
