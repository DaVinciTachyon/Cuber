import 'package:flutter/material.dart';
import 'cube_timer.dart';

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inSeconds % 60)}';
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
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.amber,
                    height:
                        controller.value * MediaQuery.of(context).size.height,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: Text(
                            timerString,
                            style: TextStyle(fontSize: 50),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) {
                          return FloatingActionButton.extended(
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
                                    ));
                              } else {
                                controller.reverse(
                                    from: controller.value == 0.0
                                        ? 1.0
                                        : controller.value);
                              }
                            },
                            icon: Icon(controller.isAnimating
                                ? Icons.pause
                                : Icons.play_arrow),
                            label:
                                Text(controller.isAnimating ? "Pause" : "Play"),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
