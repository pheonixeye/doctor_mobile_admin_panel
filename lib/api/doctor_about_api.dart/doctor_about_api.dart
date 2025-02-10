import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:doctor_mobile_admin_panel/models/doctor_about.dart';

class HxDoctorAbout {
  const HxDoctorAbout({required this.doc_id});

  final String doc_id;

  static const String collection = 'doctor_about';

  Future<DoctorAbout> addNewDoctorAbout(
    DoctorAbout doctorAbout,
  ) async {
    final _result = await PocketbaseHelper.pb.collection(collection).create(
          body: doctorAbout.toJson(),
        );

    final _docRef = await PocketbaseHelper.pb
        .collection(HxProfile.collection)
        .getOne(doc_id);

    final _doctor = Doctor.fromJson(_docRef.toJson());

    final _update = {
      'about_ids': [
        ..._doctor.about_ids,
        _result.id,
      ],
    };

    await PocketbaseHelper.pb
        .collection(HxProfile.collection)
        .update(doc_id, body: _update);

    return DoctorAbout.fromJson(_result.toJson());
  }

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

  Future<void> deleteDoctorAbout(String id) async {
    await PocketbaseHelper.pb.collection(collection).delete(id);
  }

  Future<List<DoctorAbout>> fetchDoctorAboutList() async {
    final _result = await PocketbaseHelper.pb
        .collection(collection)
        .getList(filter: 'doc_id = "$doc_id"');

    return _result.items.map((e) => DoctorAbout.fromJson(e.toJson())).toList();
  }
}
