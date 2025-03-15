import 'package:doctor_mobile_admin_panel/api/site_settings_api/site_settings_api.dart';
import 'package:doctor_mobile_admin_panel/models/site_settings.dart';
import 'package:flutter/material.dart';

class PxSiteSettings extends ChangeNotifier {
  final SiteSettingsApi service;

  PxSiteSettings({required this.service}) {
    _fetchSiteSettings();
  }

  static SiteSettings? _settings;
  SiteSettings? get settings => _settings;

  Future<void> _fetchSiteSettings() async {
    _settings = await service.fetchDoctorSiteSettings();
    notifyListeners();
  }

  Future<void> updateSiteSettings(
      String id, Map<String, dynamic> update) async {
    await service.updateSiteSettingsData(id, update);
    await _fetchSiteSettings();
  }

  Future<void> updateSiteSettingsBackground({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    await service.updateSiteSettingsWebsiteBackground(
      id: id,
      fileBytes: fileBytes,
      fileName_key: fileName_key,
    );
    await _fetchSiteSettings();
  }
}
