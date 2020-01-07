import 'package:flutter/material.dart';
import 'dart:async';
import 'includes/time.dart';

class CubeTimer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CubeTimerState();
  }
}

class CubeTimerState extends State<CubeTimer> {
  var _time;
  var _stopwatch;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = new Stopwatch();
    _time = _stopwatch.elapsedMilliseconds;
    _stopwatch.start();
    _timer = new Timer.periodic(
      Duration(
        milliseconds: 100,
      ),
      (Timer timer) {
        if (!mounted) timer?.cancel();
        setState(() {
          _time = _stopwatch.elapsedMilliseconds;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: FlatButton(
          child: Text(
            timeFormat(_time, 1),
            style: TextStyle(
              fontSize: 50,
            ),
          ),
          onPressed: () {
            if (_stopwatch.isRunning) {
              _stopwatch.stop();
              Navigator.pop(context, _time);
            } else {
              _stopwatch.reset();
              _stopwatch.start();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
