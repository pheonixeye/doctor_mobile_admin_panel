import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:doctor_mobile_admin_panel/models/doctor_about.dart';
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

class HxDoctorAboutPocketbase extends DoctorAboutApi {
  const HxDoctorAboutPocketbase({required this.doc_id});

  final String doc_id;

  static const String collection = 'doctor_about';

  @override
  Future<DoctorAbout> addNewDoctorAbout(
    DoctorAbout doctorAbout,
  ) async {
    final _result = await PocketbaseHelper.pb.collection(collection).create(
          body: doctorAbout.toJson(),
        );

    final _docRef = await PocketbaseHelper.pb
        .collection(HxProfilePocketbase.collection)
        .getOne(doc_id);

    final _doctor = Doctor.fromJson(_docRef.toJson());

    final _update = {
      'about_ids': [
        ..._doctor.about_ids ?? [],
        _result.id,
      ],
    };

    await PocketbaseHelper.pb
        .collection(HxProfilePocketbase.collection)
        .update(doc_id, body: _update);

    return DoctorAbout.fromJson(_result.toJson());
  }

  @override
  Future<DoctorAbout> updateDoctorAbout(
    String id,
    Map<String, dynamic> update,
  ) async {
    final _result = await PocketbaseHelper.pb.collection(collection).update(
          id,
          body: update,
        );

    return DoctorAbout.fromJson(_result.toJson());
  }

  @override
  Future<void> deleteDoctorAbout(String id) async {
    await PocketbaseHelper.pb.collection(collection).delete(id);
  }

  @override
  Future<List<DoctorAbout>> fetchDoctorAboutList() async {
    final _result = await PocketbaseHelper.pb
        .collection(collection)
        .getList(filter: 'doc_id = "$doc_id"');

    return _result.items.map((e) => DoctorAbout.fromJson(e.toJson())).toList();
  }
}

class HxDoctorAboutSupabase extends DoctorAboutApi {
  HxDoctorAboutSupabase({required this.doc_id});

  final String doc_id;

  static const String collection = 'doctor_about';

  @override
  Future<DoctorAbout> addNewDoctorAbout(DoctorAbout doctorAbout) async {
    final result = await (DataSourceHelper.ds as SupabaseClient)
        .from(collection)
        .insert(doctorAbout.toJson())
        .select();
    return DoctorAbout.fromJson(result.first);
  }

  @override
  Future<void> deleteDoctorAbout(String id) async {
    await (DataSourceHelper.ds as SupabaseClient)
        .from(collection)
        .delete()
        .eq('id', id);
  }

  @override
  Future<List<DoctorAbout>> fetchDoctorAboutList() async {
    final result = await (DataSourceHelper.ds as SupabaseClient)
        .from(collection)
        .select()
        .eq('doc_id', doc_id);
    return result.map((e) => DoctorAbout.fromJson(e)).toList();
  }

  @override
  Future<DoctorAbout> updateDoctorAbout(
      String id, Map<String, dynamic> update) async {
    final result = await (DataSourceHelper.ds as SupabaseClient)
        .from(collection)
        .update(update)
        .eq('id', id)
        .select()
        .count(CountOption.exact);
    return DoctorAbout.fromJson(result.data.first);
  }
}
