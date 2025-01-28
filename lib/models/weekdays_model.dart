// ignore_for_file: non_constant_identifier_names, constant_identifier_names

class Weekday {
  final String weekdayEn;
  final String weekdayAr;
  final int intDay;

  const Weekday({
    required this.weekdayEn,
    required this.weekdayAr,
    required this.intDay,
  });

  static const List<Weekday> WEEKDAYS = [
    Weekday(
      weekdayEn: 'Monday',
      weekdayAr: 'الاثنين',
      intDay: 1,
    ),
    Weekday(
      weekdayEn: 'Tuesday',
      weekdayAr: 'الثلاثاء',
      intDay: 2,
    ),
    Weekday(
      weekdayEn: 'Wednesday',
      weekdayAr: 'الاربعاء',
      intDay: 3,
    ),
    Weekday(
      weekdayEn: 'Thursday',
      weekdayAr: 'الخميس',
      intDay: 4,
    ),
    Weekday(
      weekdayEn: 'Friday',
      weekdayAr: 'الجمعة',
      intDay: 5,
    ),
    Weekday(
      weekdayEn: 'Saturday',
      weekdayAr: 'السبت',
      intDay: 6,
    ),
    Weekday(
      weekdayEn: 'Sunday',
      weekdayAr: 'الاحد',
      intDay: 7,
    ),
  ];
}
