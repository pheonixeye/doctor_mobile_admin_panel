import 'package:doctor_mobile_admin_panel/api/bookings_api/bookings_api.dart';
import 'package:doctor_mobile_admin_panel/models/booking.dart';
import 'package:flutter/material.dart';

class PxBookings extends ChangeNotifier {
  final BookingsApi service;

  PxBookings({required this.service}) {
    _fetchBookings();
  }

  static List<Booking>? _bookings;
  List<Booking>? get bookings => _bookings;

  static List<Booking>? _filteredBookings;
  List<Booking>? get filteredBookings => _filteredBookings;

  Future<void> _fetchBookings() async {
    _bookings = await service.getDoctorBookings();
    _filteredBookings = _bookings;
    notifyListeners();
  }

  void filterBookings(String date) {
    _filteredBookings = _filteredBookings?.where((b) {
      return b.date == date;
    }).toList();
    notifyListeners();
  }

  void resetBookings() {
    _filteredBookings = _bookings;
    notifyListeners();
  }
}
