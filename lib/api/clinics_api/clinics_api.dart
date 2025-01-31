import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/functions/pretty_json.dart';
import 'package:doctor_mobile_admin_panel/models/clinic.dart';
import 'package:doctor_mobile_admin_panel/models/clinic_response_model.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:doctor_mobile_admin_panel/models/schedule.dart';
import 'package:pocketbase/pocketbase.dart';

class HxClinics {
  const HxClinics(this.doc_id);

  final String doc_id;

  static const String collection = 'clinics';
  static const String _expand = 'schedule_ids, off_dates';

  Future<List<ClinicResponseModel>?> fetchDoctorClinicsByDoctorId() async {
    //TODO

    final result = await PocketbaseHelper.pb.collection(collection).getList(
          filter: 'doc_id = "$doc_id"',
          expand: _expand,
        );

    final _clinics = result.items
        .map((e) => ClinicResponseModel(
              clinic: Clinic.fromJson(e.toJson()),
              schedule: e
                  .get<List<RecordModel>>('expand.schedule_ids')
                  .map((e) => Schedule.fromJson(e.toJson()))
                  .toList(),
              offDates: e
                  .get<List<RecordModel>>('expand.off_dates')
                  .map((e) => e.get<String>('off_date'))
                  .toList(),
            ))
        .toList();
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

  static const String _schedulesCollection = 'schedules';

  Future<void> addClinicSchedule(Schedule schedule) async {
    final result =
        await PocketbaseHelper.pb.collection(_schedulesCollection).create(
              body: schedule.toJson(),
            );
    final _sch = Schedule.fromJson(result.toJson());

    final _clinic_ref =
        await PocketbaseHelper.pb.collection(collection).getOne(_sch.clinic_id);

    final _clinic = Clinic.fromJson(_clinic_ref.toJson());

    final _update = {
      'schedule_ids': [
        ..._clinic.schedule_ids,
        _sch.id,
      ],
    };

    await PocketbaseHelper.pb.collection(collection).update(
          _sch.clinic_id,
          body: _update,
        );
  }

  Future<void> deleteClinicSchedule(
    String schedule_id,
  ) async {
    await PocketbaseHelper.pb
        .collection(_schedulesCollection)
        .delete(schedule_id);
  }

  Future<void> updateClinicSchedule(
    Schedule newSchedule,
  ) async {
    await PocketbaseHelper.pb.collection(_schedulesCollection).update(
          newSchedule.id,
          body: newSchedule.toJson(),
        );
  }
}
