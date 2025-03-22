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

  static const String _format = 'dd / MM / yyyy';
  static DateTime _date = DateTime.now();
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
  }

  Future<void> _fetchBookings() async {
    _bookings = await service.getDoctorBookings();
    _filteredBookings = _bookings;
    notifyListeners();
  }

  void filterBookings() {
    _filteredBookings = _filteredBookings?.where((b) {
      return b.date == stringDate;
    }).toList();
    notifyListeners();
  }

  void resetBookings() {
    _filteredBookings = _bookings;
    notifyListeners();
  }
}
