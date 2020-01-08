String timeFormat(int time, int noOfMilli) {
  double seconds = ((time / 1000) % 60);
  int minutes = (time / (60 * 1000) % 60).floor();
  int hours = (time / (60 * 60 * 1000)).floor();
  String displayTime = "${seconds.toStringAsFixed(noOfMilli)}";
  if (minutes > 0 || hours > 0) {
    if (seconds < 10) displayTime = "0$displayTime";
    displayTime = "$minutes:$displayTime";
  }
  if (hours > 0) {
    if (minutes < 10) displayTime = "0$displayTime";
    displayTime = "$hours:$displayTime";
  }
  return displayTime;
}
