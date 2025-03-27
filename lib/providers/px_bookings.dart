import 'package:doctor_mobile_admin_panel/api/bookings_api/bookings_api.dart';
import 'package:doctor_mobile_admin_panel/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PxBookings extends ChangeNotifier {
  final BookingsApi service;

  PxBookings({required this.service}) {
    _fetchBookings();
    filterBookings();
  }

  static List<Booking>? _bookings;
  List<Booking>? get bookings => _bookings;

  static List<Booking>? _filteredBookings;
  List<Booking>? get filteredBookings => _filteredBookings;

  static const String _format = 'yyyy-MM-dd';
  static DateTime _date = DateTime.now();
  static final DateTime NOW = DateTime.now();
  DateTime get date => _date;
  String get stringDate => DateFormat(_format, 'en').format(_date);

  void setDate({int? d, int? m, int? y}) {
    _date = _date.copyWith(
      year: y ?? _date.year,
      month: m ?? _date.month,
      day: d ?? _date.day,
    );
    notifyListeners();
    filterBookings();
    // print(stringDate);
  }

  Future<void> _fetchBookings() async {
    _bookings = await service.getDoctorBookings();
    _filteredBookings = _bookings
        ?.where((b) =>
            DateTime.parse(b.date!) == DateTime(NOW.year, NOW.month, NOW.day))
        .toList();
    notifyListeners();
  }

  void filterBookings() {
    _filteredBookings = _bookings?.where((b) {
      return DateTime.parse(b.date!) == DateTime.parse(stringDate);
    }).toList();
    notifyListeners();
    // print(_filteredBookings?.map((e) => e.toJson()).toList());
  }

  void filterThisMonthBooking() {
    _filteredBookings = _bookings?.where((b) {
      final _bDate = DateTime.parse(b.date!);
      final _mDate = DateTime(_date.year, _date.month);
      return (_bDate.year == _mDate.year && _bDate.month == _mDate.month);
    }).toList();
    notifyListeners();
    // print(_filteredBookings?.map((e) => e.toJson()).toList());
  }

  void resetBookings() {
    _filteredBookings = _bookings;
    notifyListeners();
  }
}
