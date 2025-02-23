import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/extensions/annotations.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:doctor_mobile_admin_panel/models/doctor_about.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class DoctorAboutApi {
  const DoctorAboutApi();
  Future<DoctorAbout> addNewDoctorAbout(DoctorAbout doctorAbout);
  Future<DoctorAbout> updateDoctorAbout(String id, Map<String, dynamic> update);
  Future<void> deleteDoctorAbout(String id);
  Future<List<DoctorAbout>> fetchDoctorAboutList();

  static final DataSourceHelper _helper = DataSourceHelper();

  factory DoctorAboutApi.common({required String doc_id}) {
    return switch (_helper.dataSource) {
      DataSource.pb => HxDoctorAboutPocketbase(doc_id: doc_id),
      DataSource.sb => HxDoctorAboutSupabase(doc_id: doc_id),
    };
  }
}

@POCKETBASE()
class HxDoctorAboutPocketbase extends DoctorAboutApi {
  HxDoctorAboutPocketbase({required this.doc_id});

  final String doc_id;

  static const String collection = 'doctor_about';

  final _client = (DataSourceHelper.ds as PocketBase);

  @override
  Future<DoctorAbout> addNewDoctorAbout(
    DoctorAbout doctorAbout,
  ) async {
    final _result = await _client.collection(collection).create(
          body: doctorAbout.toJson(),
        );

    final _docRef =
        await _client.collection(HxProfilePocketbase.collection).getOne(doc_id);

    final _doctor = Doctor.fromJson(_docRef.toJson());

    final _update = {
      'about_ids': [
        ..._doctor.about_ids ?? [],
        _result.id,
      ],
    };

    await _client
        .collection(HxProfilePocketbase.collection)
        .update(doc_id, body: _update);

    return DoctorAbout.fromJson(_result.toJson());
  }

  @override
  Future<DoctorAbout> updateDoctorAbout(
    String id,
    Map<String, dynamic> update,
  ) async {
    final _result = await _client.collection(collection).update(
          id,
          body: update,
        );

    return DoctorAbout.fromJson(_result.toJson());
  }

  @override
  Future<void> deleteDoctorAbout(String id) async {
    await _client.collection(collection).delete(id);
  }

  @override
  Future<List<DoctorAbout>> fetchDoctorAboutList() async {
    final _result = await _client
        .collection(collection)
        .getList(filter: 'doc_id = "$doc_id"');

    return _result.items.map((e) => DoctorAbout.fromJson(e.toJson())).toList();
  }
}

@SUPABASE()
class HxDoctorAboutSupabase extends DoctorAboutApi {
  HxDoctorAboutSupabase({required this.doc_id});

  final String doc_id;

  static const String collection = 'doctor_about';

  final _client = (DataSourceHelper.ds as SupabaseClient);

  @override
  Future<DoctorAbout> addNewDoctorAbout(DoctorAbout doctorAbout) async {
    final result = await _client
        .from(collection)
        .insert(doctorAbout.toSupabaseJson())
        .select();
    return DoctorAbout.fromJson(result.first);
  }

  @override
  Future<void> deleteDoctorAbout(String id) async {
    await _client.from(collection).delete().eq('id', id);
  }

  @override
  Future<List<DoctorAbout>> fetchDoctorAboutList() async {
    final result = await _client.from(collection).select().eq('doc_id', doc_id);
    return result.map((e) => DoctorAbout.fromJson(e)).toList();
  }

  @override
  Future<DoctorAbout> updateDoctorAbout(
      String id, Map<String, dynamic> update) async {
    final result = await _client
        .from(collection)
        .update(update)
        .eq('id', id)
        .select()
        .count(CountOption.exact);
    return DoctorAbout.fromJson(result.data.first);
  }
}
