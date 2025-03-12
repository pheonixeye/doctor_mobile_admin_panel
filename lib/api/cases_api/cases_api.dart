import 'dart:typed_data';

import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/extensions/annotations.dart';
import 'package:doctor_mobile_admin_panel/models/case.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CasesApi {
  const CasesApi();

  static final DataSourceHelper _helper = DataSourceHelper();

  Future<Case> addNewCase(Case case_);
  Future<List<Case>?> fetchDoctorCases();
  Future<Case> updateCaseData(String id, Map<String, dynamic> update);
  Future<void> updateCaseImage({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  });
  Future<void> deleteCase(String id);

  factory CasesApi.common({required String doc_id}) {
    return switch (_helper.dataSource) {
      DataSource.pb => HxCasesPocketbase(doc_id: doc_id),
      DataSource.sb => HxCasesSupabase(doc_id: doc_id),
    };
  }
}

@POCKETBASE()
class HxCasesPocketbase extends CasesApi {
  HxCasesPocketbase({required this.doc_id});

  final String doc_id;

  static const String collection = 'cases';

  final _client = (DataSourceHelper.ds as PocketBase);

  @override
  Future<Case> addNewCase(Case case_) async {
    final _result = await _client.collection(collection).create(
          body: case_.toJson(),
        );
    final _doctorFetchResponse =
        await _client.collection(HxProfilePocketbase.collection).getOne(doc_id);

    final doctor = Doctor.fromJson(_doctorFetchResponse.toJson());

    final _update = {
      'cases_ids': [
        ...doctor.cases_ids ?? [],
        _result.id,
      ],
    };
    await _client.collection(HxProfilePocketbase.collection).update(
          doc_id,
          body: _update,
        );
    return Case.fromJson(_result.toJson());
  }

  @override
  Future<List<Case>?> fetchDoctorCases() async {
    //TODO: pagination
    final _result = await _client.collection(collection).getList(
          filter: 'doc_id = "$doc_id"',
        );
    return _result.items.map((e) => Case.fromJson(e.toJson())).toList();
  }

  @override
  Future<Case> updateCaseData(String id, Map<String, dynamic> update) async {
    final _result = await _client.collection(collection).update(
          id,
          body: update,
        );

    return Case.fromJson(_result.toJson());
  }

  @override
  Future<Case> updateCaseImage({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    try {
      final updateCaseResponse = await _client.collection(collection).update(
        id,
        files: [
          http.MultipartFile.fromBytes(
            fileName_key,
            fileBytes,
            filename: fileName_key,
          ),
        ],
      );

      final case_ = Case.fromJson(
        updateCaseResponse.toJson(),
      );

      return case_;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCase(String id) async {
    await _client.collection(collection).delete(id);
  }
}

@SUPABASE()
class HxCasesSupabase extends CasesApi {
  final String doc_id;

  static const String collection = 'cases';

  HxCasesSupabase({required this.doc_id});

  final _client = (DataSourceHelper.ds as SupabaseClient);

  @override
  Future<Case> addNewCase(Case case_) async {
    final _result =
        await _client.from(collection).insert(case_.toSupabaseJson()).select();

    return Case.fromJson(_result.first);
  }

  @override
  Future<void> deleteCase(String id) async {
    await _client.from(collection).delete().eq('id', id);
  }

  @override
  Future<List<Case>?> fetchDoctorCases() async {
    final _result =
        await _client.from(collection).select().eq('doc_id', doc_id);
    return _result.map((e) => Case.fromJson(e)).toList();
  }

  @override
  Future<void> updateCaseImage({
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

    final _update = {
      fileName_key.split('.').first: _pathDebased,
    };

    await _client.from(collection).update(_update).eq('id', id);
  }

  @override
  Future<Case> updateCaseData(String id, Map<String, dynamic> update) async {
    final _result =
        await _client.from(collection).update(update).eq('id', id).select();

    return Case.fromJson(_result.first);
  }
}
