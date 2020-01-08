import 'package:flutter/material.dart';
import 'dart:async';
import 'includes/time.dart';

class CubeTimer extends StatefulWidget {
  final int penalty;
  final int limit;

  CubeTimer({this.penalty = 0, this.limit = 10 * 60});

  @override
  State<StatefulWidget> createState() => _CubeTimerState(penalty, limit);
}

class _CubeTimerState extends State<CubeTimer> {
  var _time;
  var _stopwatch;
  Timer _timer;
  int _penalty;
  int _limit;

  _CubeTimerState(this._penalty, this._limit);

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
        if (_stopwatch.elapsed.inSeconds >= _limit) {
          _stopwatch.stop();
          Navigator.pop(context, -1);
          timer?.cancel();
        }
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
              _time += _penalty * 1000;
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
