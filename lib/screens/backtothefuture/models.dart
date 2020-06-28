class TimeLapse {
  String month;
  String day;
  String year;
  String hour;
  String minutes;
  TimeZone timeZone;
  String description;

  TimeLapse(
      {this.month,
      this.day,
      this.year,
      this.hour,
      this.minutes,
      this.timeZone,
      this.description});
}

enum TimeZone { AM, PM }
