import 'package:flutter/material.dart';
import 'dart:async';

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
    String milliseconds = '${_time.value % 1000}'.padLeft(3, '0');
    String seconds = '${(_time.value / 1000) % 60}'.padLeft(2, '0');
    String minutes = '${(_time.value / 60000)}'.padLeft(2, '0');
    return SizedBox.expand(
      child: FlatButton(
        child: Text('$minutes:$seconds.$milliseconds'),
        onPressed: () {
          if (_stopwatch.isRunning) {
            _stopwatch.stop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(time: _time),
              ),
            );
          } else {
            _stopwatch.start();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class ResultScreen extends StatelessWidget {
  final time;

  ResultScreen({Key key, @required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(time),
      ),
    );
  }
}
