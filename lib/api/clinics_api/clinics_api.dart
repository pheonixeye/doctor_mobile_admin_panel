import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/functions/pretty_json.dart';
import 'package:doctor_mobile_admin_panel/models/clinic.dart';
import 'package:doctor_mobile_admin_panel/models/clinic_response_model.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';

class HxClinics {
  const HxClinics(this.doc_id);

  final String doc_id;

  static const String collection = 'clinics';
  static const String _expand = 'schedule_ids, off_dates';

  Future<List<Clinic>?> fetchDoctorClinicsByDoctorId() async {
    //TODO

    final result = await PocketbaseHelper.pb.collection(collection).getList(
          filter: 'doc_id = "$doc_id"',
          expand: _expand,
        );

    final _clinics =
        result.items.map((e) => Clinic.fromJson(e.toJson())).toList();
    dprintPretty(result);
    return _clinics;
  }

  Future<Clinic?> createClinic(Clinic clinic) async {
    final clinicCreationResult =
        await PocketbaseHelper.pb.collection(collection).create(
              body: clinic.toJson(),
            );

    final _doctorFetchResult = await PocketbaseHelper.pb
        .collection(HxProfile.collection)
        .getFirstListItem('id = "$doc_id"');

    final _doctor = Doctor.fromJson(_doctorFetchResult.toJson());

    final _update = {
      'clinic_ids': [..._doctor.clinic_ids, clinicCreationResult.id],
    };

    await PocketbaseHelper.pb.collection(HxProfile.collection).update(
          _doctor.id,
          body: _update,
        );

    final _clinic = Clinic.fromJson(clinicCreationResult.toJson());

    return _clinic;
  }

  Future<void> deleteClinic(String clinic_id) async {
    await PocketbaseHelper.pb.collection(collection).delete(clinic_id);
  }

  Future<Clinic?> updateClinicData(
    String clinic_id,
    String key,
    dynamic value,
  ) async {
    //TODO
    final result = await PocketbaseHelper.pb.collection(collection).update(
          clinic_id,
          body: {
            key: value,
          },
          expand: _expand,
        );

    final clinic = Clinic.fromJson(result.toJson());

    return clinic;
  }

  Future<ClinicResponseModel?> updateClinicSchedule() async {}

  Future<ClinicResponseModel?> updateClinicOffDates() async {}
}
