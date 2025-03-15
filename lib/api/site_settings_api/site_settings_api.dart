import 'dart:typed_data';

import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/extensions/annotations.dart';
import 'package:doctor_mobile_admin_panel/models/site_settings.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

abstract class SiteSettingsApi {
  const SiteSettingsApi();

  static final DataSourceHelper _helper = DataSourceHelper();

  // ignore: unused_element
  Future<SiteSettings> _checkIfSiteSettingsExist();
  Future<SiteSettings> fetchDoctorSiteSettings();
  Future<void> updateSiteSettingsData(
    String id,
    Map<String, dynamic> update,
  );
  Future<void> updateSiteSettingsWebsiteBackground({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  });

  factory SiteSettingsApi.common(String doc_id) {
    return switch (_helper.dataSource) {
      DataSource.pb => HxSiteSettingsPocketbase(doc_id: doc_id),
      DataSource.sb => HxSiteSettingsSupabase(doc_id: doc_id),
    };
  }
}

@POCKETBASE()
class HxSiteSettingsPocketbase extends SiteSettingsApi {
  final String doc_id;

  HxSiteSettingsPocketbase({required this.doc_id});

  static const String collection = 'site_settings';

  final _client = DataSourceHelper.ds as PocketBase;

  @override
  Future<SiteSettings> _checkIfSiteSettingsExist() async {
    final _result = await _client
        .collection(collection)
        .getFirstListItem('doc_id = "$doc_id"');

    if (_result.data.isEmpty) {
      final _siteSettingCreateResult =
          await _client.collection(collection).create(
        body: {'doc_id': doc_id},
      );
      return SiteSettings.fromJson(_siteSettingCreateResult.toJson());
    } else {
      return SiteSettings.fromJson(_result.toJson());
    }
  }

  @override
  Future<SiteSettings> fetchDoctorSiteSettings() async {
    final _result = await _checkIfSiteSettingsExist();
    return _result;
  }

  @override
  Future<void> updateSiteSettingsData(
      String id, Map<String, dynamic> update) async {
    await _client.collection(collection).update(id, body: update);
  }

  @override
  Future<void> updateSiteSettingsWebsiteBackground({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    try {
      await _client.collection(collection).update(
        doc_id,
        files: [
          http.MultipartFile.fromBytes(
            fileName_key,
            fileBytes,
            filename: fileName_key,
          ),
        ],
      );
    } catch (e) {
      rethrow;
    }
  }
}

@POCKETBASE()
class HxSiteSettingsSupabase extends SiteSettingsApi {
  final String doc_id;

  HxSiteSettingsSupabase({required this.doc_id});

  static const String collection = 'site_settings';

  final _client = DataSourceHelper.ds as SupabaseClient;

  @override
  Future<SiteSettings> _checkIfSiteSettingsExist() async {
    final _result =
        await _client.from(collection).select().eq('doc_id', doc_id);
    if (_result.isEmpty) {
      final _siteSettingsCreateResult = await _client.from(collection).insert(
        {'doc_id': doc_id},
      ).select();
      return SiteSettings.fromJson(_siteSettingsCreateResult.first);
    } else {
      return SiteSettings.fromJson(_result.first);
    }
  }

  @override
  Future<SiteSettings> fetchDoctorSiteSettings() async {
    final _result = await _checkIfSiteSettingsExist();
    return _result;
  }

  @override
  Future<void> updateSiteSettingsData(
    String id,
    Map<String, dynamic> update,
  ) async {
    await _client.from(collection).update(update).eq('doc_id', doc_id);
  }

  @override
  Future<void> updateSiteSettingsWebsiteBackground({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    final _data = Uint8List.fromList(fileBytes);
    // final _file = File.fromRawPath(_data);
    //TODO: change for mobile
    final result = await _client.storage.from('base').uploadBinary(
          '$doc_id/$collection/$id/$fileName_key',
          _data,
          fileOptions: const FileOptions(
            cacheControl: '3600',
            upsert: true,
          ),
        );

    String _pathDebased = result.replaceFirstMapped('base/', (m) => '');
    final String _key = fileName_key.split('.').first;

    final _update = {
      _key: _pathDebased,
    };

    await _client.from(collection).update(_update).eq('id', id);
  }
}
