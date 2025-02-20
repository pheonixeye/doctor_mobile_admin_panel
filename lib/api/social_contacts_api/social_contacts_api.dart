import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/models/social_contact.dart';
import 'package:pocketbase/pocketbase.dart';

class HxSocialContacts {
  const HxSocialContacts({required this.doc_id});
  static const String collection = 'social_contacts';
  final String doc_id;

  Future<void> _checkIfSocialContactExists() async {
    try {
      if (doc_id == '') {
        return;
      }
      await PocketbaseHelper.pb
          .collection(collection)
          .getFirstListItem('doc_id = "$doc_id"');
    } on ClientException {
      final _result = await PocketbaseHelper.pb.collection(collection).create(
            body: SocialContact.withDocId(doc_id).toJson(),
          );
      await PocketbaseHelper.pb
          .collection(HxProfilePocketbase.collection)
          .update(
        doc_id,
        body: {
          'social_contacts_id': _result.id,
        },
      );
    }
  }

  Future<SocialContact> fetchDoctorSocialContact() async {
    await _checkIfSocialContactExists();
    final _result = await PocketbaseHelper.pb
        .collection(collection)
        .getFirstListItem('doc_id = "$doc_id"');

    return SocialContact.fromJson(_result.toJson());
  }

  Future<SocialContact> updateSocialContactData(
    String id,
    Map<String, dynamic> update,
  ) async {
    await _checkIfSocialContactExists();

    final _result = await PocketbaseHelper.pb.collection(collection).update(
          id,
          body: update,
        );
    return SocialContact.fromJson(_result.toJson());
  }
}
