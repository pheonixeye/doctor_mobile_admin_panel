import 'package:doctor_mobile_admin_panel/api/doctor_about_api.dart/doctor_about_api.dart';
import 'package:doctor_mobile_admin_panel/models/doctor_about.dart';
import 'package:flutter/material.dart';

class PxDoctorAbout extends ChangeNotifier {
  final HxDoctorAbout service;

  PxDoctorAbout({required this.service}) {
    _fetchAbouts();
  }

  static List<DoctorAbout>? _abouts;
  List<DoctorAbout>? get abouts => _abouts;

  Future<void> _fetchAbouts() async {
    _abouts = await service.fetchDoctorAboutList();
    notifyListeners();
  }

  Future<void> addNewAbout(DoctorAbout about) async {
    await service.addNewDoctorAbout(about);
    await _fetchAbouts();
  }

  Future<void> updateAbout(String id, Map<String, dynamic> update) async {
    await service.updateDoctorAbout(id, update);
    await _fetchAbouts();
  }

  Future<void> deleteAbout(String id) async {
    await service.deleteDoctorAbout(id);
    await _fetchAbouts();
  }
}
