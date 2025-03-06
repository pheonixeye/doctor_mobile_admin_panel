import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/extensions/annotations.dart';
import 'package:doctor_mobile_admin_panel/models/social_contact.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SocialContactsApi {
  const SocialContactsApi();

  static final DataSourceHelper _helper = DataSourceHelper();

  // ignore: unused_element
  Future<void> _checkIfSocialContactExists();
  Future<SocialContact> fetchDoctorSocialContact();
  Future<SocialContact> updateSocialContactData(
      String id, Map<String, dynamic> update);

  factory SocialContactsApi.common({required String doc_id}) {
    return switch (_helper.dataSource) {
      DataSource.pb => HxSocialContactsPocketbase(doc_id: doc_id),
      DataSource.sb => HxSocialContactsSupabase(doc_id: doc_id),
    };
  }
}

@POCKETBASE()
class HxSocialContactsPocketbase extends SocialContactsApi {
  HxSocialContactsPocketbase({required this.doc_id});

  static const String collection = 'social_contacts';

  final String doc_id;

  final _client = DataSourceHelper.ds as PocketBase;

  @override
  Future<void> _checkIfSocialContactExists() async {
    try {
      if (doc_id == '') {
        return;
      }
      await _client
          .collection(collection)
          .getFirstListItem('doc_id = "$doc_id"');
    } on ClientException {
      final _result = await _client.collection(collection).create(
            body: SocialContact.withDocId(doc_id).toJson(),
          );
      await _client.collection(HxProfilePocketbase.collection).update(
        doc_id,
        body: {
          'social_contacts_id': _result.id,
        },
      );
    }
  }

  @override
  Future<SocialContact> fetchDoctorSocialContact() async {
    await _checkIfSocialContactExists();
    final _result = await _client
        .collection(collection)
        .getFirstListItem('doc_id = "$doc_id"');

    return SocialContact.fromJson(_result.toJson());
  }

  @override
  Future<SocialContact> updateSocialContactData(
    String id,
    Map<String, dynamic> update,
  ) async {
    await _checkIfSocialContactExists();

    final _result = await _client.collection(collection).update(
          id,
          body: update,
        );
    return SocialContact.fromJson(_result.toJson());
  }
}

@SUPABASE()
class HxSocialContactsSupabase extends SocialContactsApi {
  final String doc_id;

  HxSocialContactsSupabase({required this.doc_id});

  final _client = DataSourceHelper.ds as SupabaseClient;

  static const String collection = 'social_contacts';

  @override
  Future<void> _checkIfSocialContactExists() async {
    if (doc_id == '') {
      return;
    }
    try {
      final _result =
          await _client.from(collection).select().eq('doc_id', doc_id);
      if (_result.isEmpty) {
        throw UnimplementedError();
      }
    } catch (e) {
      await _client
          .from(collection)
          .insert(SocialContact.withDocId(doc_id).toSupabaseJson());
    }
  }

  @override
  Future<SocialContact> fetchDoctorSocialContact() async {
    await _checkIfSocialContactExists();
    final _result =
        await _client.from(collection).select().eq('doc_id', doc_id);
    return SocialContact.fromJson(_result.first);
  }

  @override
  Future<SocialContact> updateSocialContactData(
      String id, Map<String, dynamic> update) async {
    await _checkIfSocialContactExists();
    final _result =
        await _client.from(collection).update(update).eq('id', id).select();
    return SocialContact.fromJson(_result.first);
  }
}
