import 'package:doctor_mobile_admin_panel/api/social_contacts_api/social_contacts_api.dart';
import 'package:doctor_mobile_admin_panel/models/social_contact.dart';
import 'package:flutter/material.dart';

class PxSocialContact extends ChangeNotifier {
  final HxSocialContacts socialContactsService;

  PxSocialContact({required this.socialContactsService}) {
    _fetchSocialContact();
  }

  SocialContact? _socialContact;
  SocialContact? get socialContact => _socialContact;

  Future<void> _fetchSocialContact() async {
    _socialContact = await socialContactsService.fetchDoctorSocialContact();
    notifyListeners();
  }

  Future<void> updateSocialContactData(Map<String, dynamic> update) async {
    await socialContactsService.updateSocialContactData(
      _socialContact!.id,
      update,
    );
    await _fetchSocialContact();
  }
}
