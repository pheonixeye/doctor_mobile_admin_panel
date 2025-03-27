import 'dart:typed_data';

import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/extensions/annotations.dart';
import 'package:doctor_mobile_admin_panel/models/clinic.dart';
import 'package:doctor_mobile_admin_panel/models/clinic_response_model.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:doctor_mobile_admin_panel/models/schedule.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ClinicsApi {
  const ClinicsApi();

  Future<List<ClinicResponseModel>?> fetchDoctorClinicsByDoctorId();
  Future<Clinic?> createClinic(Clinic clinic);
  Future<void> deleteClinic(String clinic_id);
  Future<Clinic?> updateClinicData(String clinic_id, String key, dynamic value);
  Future<void> updateClinicImage({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  });

  Future<void> addClinicSchedule(Schedule schedule);
  Future<void> deleteClinicSchedule(String schedule_id);
  Future<void> updateClinicSchedule(Schedule newSchedule);

  static final DataSourceHelper _helper = DataSourceHelper();

  factory ClinicsApi.common({required String doc_id}) {
    return switch (_helper.dataSource) {
      DataSource.pb => HxClinicsPocketbase(doc_id: doc_id),
      DataSource.sb => HxClinicsSupabase(doc_id: doc_id),
    };
  }
}

@POCKETBASE()
class HxClinicsPocketbase extends ClinicsApi {
  HxClinicsPocketbase({required this.doc_id});

  final String doc_id;

  static const String collection = 'clinics';
  static const String _expand = 'schedule_ids, off_dates';

  final _client = (DataSourceHelper.ds as PocketBase);

  @override
  Future<List<ClinicResponseModel>?> fetchDoctorClinicsByDoctorId() async {
    //todo

    final result = await _client.collection(collection).getList(
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
    // dprintPretty(result);
    return _clinics;
  }

  @override
  Future<Clinic?> createClinic(Clinic clinic) async {
    final clinicCreationResult = await _client.collection(collection).create(
          body: clinic.toJson(),
        );

    final _doctorFetchResult = await _client
        .collection(HxProfilePocketbase.collection)
        .getFirstListItem('id = "$doc_id"');

    final _doctor = Doctor.fromJson(_doctorFetchResult.toJson());

    final _update = {
      'clinic_ids': [..._doctor.clinic_ids ?? [], clinicCreationResult.id],
    };

    await _client.collection(HxProfilePocketbase.collection).update(
          _doctor.id,
          body: _update,
        );

    final _clinic = Clinic.fromJson(clinicCreationResult.toJson());

    return _clinic;
  }

  @override
  Future<void> deleteClinic(String clinic_id) async {
    await _client.collection(collection).delete(clinic_id);
  }

  @override
  Future<Clinic?> updateClinicData(
    String clinic_id,
    String key,
    dynamic value,
  ) async {
    //todo
    final result = await _client.collection(collection).update(
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

  @override
  Future<void> addClinicSchedule(Schedule schedule) async {
    final result = await _client.collection(_schedulesCollection).create(
          body: schedule.toJson(),
        );
    final _sch = Schedule.fromJson(result.toJson());

    final _clinic_ref =
        await _client.collection(collection).getOne(_sch.clinic_id);

    final _clinic = Clinic.fromJson(_clinic_ref.toJson());

    final _update = {
      'schedule_ids': [
        ..._clinic.schedule_ids ?? [],
        _sch.id,
      ],
    };

    await _client.collection(collection).update(
          _sch.clinic_id,
          body: _update,
        );
  }

  @override
  Future<void> deleteClinicSchedule(
    String schedule_id,
  ) async {
    await _client.collection(_schedulesCollection).delete(schedule_id);
  }

  @override
  Future<void> updateClinicSchedule(
    Schedule newSchedule,
  ) async {
    await _client.collection(_schedulesCollection).update(
          newSchedule.id,
          body: newSchedule.toJson(),
        );
  }

  @override
  Future<void> updateClinicImage({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    // TODO: implement updateClinicImage
    throw UnimplementedError();
  }
}

@SUPABASE()
class HxClinicsSupabase extends ClinicsApi {
  HxClinicsSupabase({required this.doc_id});

  final String doc_id;

  static const String collection = 'clinics';

  static const String _schedulesCollection = 'schedules';

  final _client = (DataSourceHelper.ds as SupabaseClient);

  @override
  Future<Clinic?> createClinic(Clinic clinic) async {
    final _result =
        await _client.from(collection).insert(clinic.toSupabaseJson()).select();

    return Clinic.fromJson(_result.first);
  }

  @override
  Future<void> deleteClinic(String clinic_id) async {
    await _client.from(collection).delete().eq('id', clinic_id);
  }

  @override
  Future<List<ClinicResponseModel>?> fetchDoctorClinicsByDoctorId() async {
    final rpc = 'get_clinics';

    final _params = {'doctor_id': doc_id};

    final _result = await _client.rpc(rpc, params: _params).select();

    // dprint(_result);
    return _result.map((x) {
      return ClinicResponseModel(
        offDates: [],
        clinic: Clinic.fromJson(x),
        schedule: (x['schedules'] as List<dynamic>)
            .map((y) => Schedule.fromJson(y))
            .toList(),
      );
    }).toList();
  }

  @override
  Future<Clinic?> updateClinicData(String clinic_id, String key, value) async {
    final _result = await _client
        .from(collection)
        .update({key: value})
        .eq('id', clinic_id)
        .select();

    return Clinic.fromJson(_result.first);
  }

  @override
  Future<void> addClinicSchedule(Schedule schedule) async {
    await _client.from(_schedulesCollection).insert(schedule.toSupabaseJson());
  }

  @override
  Future<void> deleteClinicSchedule(String schedule_id) async {
    await _client.from(_schedulesCollection).delete().eq('id', schedule_id);
  }

  @override
  Future<void> updateClinicSchedule(Schedule newSchedule) async {
    await _client
        .from(_schedulesCollection)
        .update({...newSchedule.toSupabaseJson()}).eq('id', newSchedule.id);
  }

  @override
  Future<void> updateClinicImage({
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
}
