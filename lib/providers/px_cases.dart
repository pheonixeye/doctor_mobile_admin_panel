import 'package:doctor_mobile_admin_panel/api/cases_api/cases_api.dart';
import 'package:doctor_mobile_admin_panel/models/case.dart';
import 'package:flutter/material.dart';

class PxCases extends ChangeNotifier {
  final HxCases service;

  PxCases({required this.service}) {
    _fetchDoctorCases();
  }

  static List<Case>? _cases;
  List<Case>? get cases => _cases;

  Future<void> _fetchDoctorCases() async {
    _cases = await service.fetchDoctorCases();
    notifyListeners();
  }

  Future<void> addNewCase(Case case_) async {
    await service.addNewCase(case_);
    await _fetchDoctorCases();
  }

  Future<void> updateCaseData(
    String id,
    Map<String, dynamic> update,
  ) async {
    await service.updateCaseData(id, update);
    await _fetchDoctorCases();
  }

  Future<void> updateCaseImage({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    await service.updateCaseImage(
      id: id,
      fileBytes: fileBytes,
      fileName_key: fileName_key,
    );
    await _fetchDoctorCases();
  }

  Future<void> deleteCase(String id) async {
    await service.deleteCase(id);
    await _fetchDoctorCases();
  }
}
