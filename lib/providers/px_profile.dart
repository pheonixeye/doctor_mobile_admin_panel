import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:flutter/material.dart';

class PxProfile extends ChangeNotifier {
  final HxProfile profileService;

  PxProfile({required this.profileService}) {
    fetchDoctorById();
  }

  static Doctor? _doctor;
  Doctor? get doctor => _doctor;

  Future<void> fetchDoctorById() async {
    _doctor = await profileService.fetchDoctorProfile();
    notifyListeners();
  }

  Future<void> editDoctorProfileByKey(String key, String value) async {
    if (doctor != null) {
      await profileService.updateDoctorProfileById(doctor!.id, key, value);
      await fetchDoctorById();
    }
  }

  Future<void> editDoctorAvatarAndLogo(String key, List<int> bytes) async {
    if (doctor != null) {
      await profileService.updateDoctorAvatarAndLogo(
        id: doctor!.id,
        fileBytes: bytes,
        fileName_key: key,
      );
      await fetchDoctorById();
    }
  }
}
