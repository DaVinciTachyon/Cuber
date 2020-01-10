import 'package:flutter/material.dart';
import 'timer.dart';

class Penalty extends StatefulWidget {
  final int penalty;

  Penalty({this.penalty = 2});

  @override
  _PenaltyTimer createState() => _PenaltyTimer(this.penalty);
}

class _PenaltyTimer extends State<Penalty> with TickerProviderStateMixin {
  AnimationController controller;
  int _penalty;

  _PenaltyTimer(this._penalty);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: _penalty,
      ),
    );
    controller.reverse(
      from: 1.0,
    );
    controller.addListener(() {
      if (controller.value == 0) Navigator.pop(context, false);
    });
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
                      color: Theme.of(context).errorColor,
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
                            "+$_penalty",
                            style: Theme.of(context).primaryTextTheme.display1,
                          ),
                          onPressed: () async {
                            controller.stop();
                            Navigator.pop(context, true);
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
