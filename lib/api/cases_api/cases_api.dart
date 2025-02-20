import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/models/case.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:http/http.dart' as http;

class HxCases {
  const HxCases({required this.doc_id});

  final String doc_id;

  static const String collection = 'cases';

  Future<Case> addNewCase(Case case_) async {
    final _result = await PocketbaseHelper.pb.collection(collection).create(
          body: case_.toJson(),
        );
    final _doctorFetchResponse = await PocketbaseHelper.pb
        .collection(HxProfilePocketbase.collection)
        .getOne(doc_id);

    final doctor = Doctor.fromJson(_doctorFetchResponse.toJson());

    final _update = {
      'cases_ids': [
        ...doctor.cases_ids ?? [],
        _result.id,
      ],
    };
    await PocketbaseHelper.pb.collection(HxProfilePocketbase.collection).update(
          doc_id,
          body: _update,
        );
    return Case.fromJson(_result.toJson());
  }

  Future<List<Case>?> fetchDoctorCases() async {
    //TODO: pagination
    final _result = await PocketbaseHelper.pb.collection(collection).getList(
          filter: 'doc_id = "$doc_id"',
        );
    return _result.items.map((e) => Case.fromJson(e.toJson())).toList();
  }

  Future<Case> updateCaseData(String id, Map<String, dynamic> update) async {
    final _result = await PocketbaseHelper.pb.collection(collection).update(
          id,
          body: update,
        );

    return Case.fromJson(_result.toJson());
  }

  Future<Case> updateCaseImage({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    try {
      final updateCaseResponse =
          await PocketbaseHelper.pb.collection(collection).update(
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

  Future<void> deleteCase(String id) async {
    await PocketbaseHelper.pb.collection(collection).delete(id);
  }
}
