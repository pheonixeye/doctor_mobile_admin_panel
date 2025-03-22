extension WeekdayToInitial on int {
  String toWeekdayString() {
    return switch (this) {
      1 => "Monday",
      2 => "Tuesday",
      3 => "Wednesday",
      4 => "Thursday",
      5 => "Friday",
      6 => "Saturday",
      7 => "Sunday",
      _ => throw UnimplementedError(),
    };
  }

  String toWeekdayInitials() {
    return switch (this) {
      1 => "Mo",
      2 => "Tu",
      3 => "We",
      4 => "Th",
      5 => "Fr",
      6 => "Sa",
      7 => "Su",
      _ => throw UnimplementedError(),
    };
  }
}
