import 'dart:typed_data';

import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/extensions/annotations.dart';
// import 'package:doctor_mobile_admin_panel/functions/pretty_json.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileApi {
  const ProfileApi();

  static final DataSourceHelper _helper = DataSourceHelper();

  Future<Doctor?> fetchDoctorProfile();
  Future<Doctor?> updateDoctorProfileById(String key, String value);
  Future<Doctor?> updateDoctorAvatarAndLogo({
    required List<int> fileBytes,
    required String fileName_key,
  });

  factory ProfileApi.common({required String doc_id}) {
    return switch (_helper.dataSource) {
      DataSource.pb => HxProfilePocketbase(doc_id: doc_id),
      DataSource.sb => HxProfileSupabase(doc_id: doc_id),
    };
  }
}

@POCKETBASE()
class HxProfilePocketbase extends ProfileApi {
  HxProfilePocketbase({required this.doc_id});

  final String doc_id;

  static const String collection = 'doctors';

  final _client = (DataSourceHelper.ds as PocketBase);

  @override
  Future<Doctor?> fetchDoctorProfile() async {
    final result = await _client.collection(collection).getOne(doc_id);

    final doctor = Doctor.fromJson(result.toJson());

    return doctor;
  }

  @override
  Future<Doctor?> updateDoctorProfileById(
    String key,
    String value,
  ) async {
    final result = await _client.collection(collection).update(
      doc_id,
      body: {
        key: value,
      },
    );

    final doctor = Doctor.fromJson(result.toJson());

    return doctor;
  }

  @override
  Future<Doctor?> updateDoctorAvatarAndLogo({
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    try {
      final updateDoctorResponse = await _client.collection(collection).update(
        doc_id,
        files: [
          http.MultipartFile.fromBytes(
            fileName_key,
            fileBytes,
            filename: fileName_key,
          ),
        ],
      );

      final doc = Doctor.fromJson(
        updateDoctorResponse.toJson(),
      );

      return doc;
    } catch (e) {
      rethrow;
    }
  }
}

@SUPABASE()
class HxProfileSupabase implements ProfileApi {
  HxProfileSupabase({required this.doc_id});

  final String doc_id;

  static const String collection = 'doctors';

  final _client = (DataSourceHelper.ds as SupabaseClient);

  @override
  Future<Doctor?> fetchDoctorProfile() async {
    final result = await _client.from(collection).select().eq('id', doc_id);
    // dprint(result.first);
    final doctor = Doctor.fromJson(result.first);
    return doctor;
  }

  @override
  Future<Doctor?> updateDoctorAvatarAndLogo({
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    final _data = Uint8List.fromList(fileBytes);
    // final _file = File.fromRawPath(_data);
    //TODO: change for mobile
    final result = await _client.storage.from('base').uploadBinary(
          '$doc_id/$fileName_key',
          _data,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );
    String _pathDebased = result.replaceFirstMapped('base/', (m) => '');
    final _update = {
      fileName_key.split('.').first: _pathDebased,
    };
    // print(_update);
    final _doctorUpdateResult = await _client
        .from(collection)
        .update(_update)
        .eq('id', doc_id)
        .select();

    return Doctor.fromJson(_doctorUpdateResult.first);
  }

  @override
  Future<Doctor?> updateDoctorProfileById(String key, String value) async {
    final result = await _client
        .from(collection)
        .update({key: value})
        .eq('id', doc_id)
        .select();
    final doctor = Doctor.fromJson(result.first);
    return doctor;
  }
}
