import 'package:doctor_mobile_admin_panel/api/clinics_api/clinics_api.dart';
import 'package:doctor_mobile_admin_panel/models/clinic.dart';
import 'package:doctor_mobile_admin_panel/models/clinic_response_model.dart';
import 'package:doctor_mobile_admin_panel/models/schedule.dart';
import 'package:flutter/material.dart';

class PxClinics extends ChangeNotifier {
  final HxClinics clinicsService;

  PxClinics({required this.clinicsService}) {
    _fetchDoctorClinicsById();
  }

  static List<ClinicResponseModel>? _clinics;
  List<ClinicResponseModel>? get clinics => _clinics;

  Future<void> _fetchDoctorClinicsById() async {
    _clinics = await clinicsService.fetchDoctorClinicsByDoctorId();
    notifyListeners();
    // dprintPretty(_clinics);
  }

  Future<void> createClinic(Clinic clinic) async {
    await clinicsService.createClinic(clinic);
    await _fetchDoctorClinicsById();
  }

  Future<void> deleteClinic(String id) async {
    await clinicsService.deleteClinic(id);
    await _fetchDoctorClinicsById();
  }

  Future<void> updateClinicData(
    String id,
    String key,
    String value,
  ) async {
    await clinicsService.updateClinicData(id, key, value);
    await _fetchDoctorClinicsById();
  }

  Future<void> addClinicSchedule(Schedule schedule) async {
    await clinicsService.addClinicSchedule(schedule);
    await _fetchDoctorClinicsById();
  }

  Future<void> deleteClinicSchedule(String id) async {
    await clinicsService.deleteClinicSchedule(id);
    await _fetchDoctorClinicsById();
  }

  Future<void> updateClinicSchedule(Schedule schedule) async {
    await clinicsService.updateClinicSchedule(schedule);
    await _fetchDoctorClinicsById();
  }
}
