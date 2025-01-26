import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:http/http.dart' as http;

class HxProfile {
  const HxProfile(this.user_id);
  final String user_id;

  static const String collection = 'doctors';

  Future<Doctor?> fetchDoctorProfile() async {
    final result = await PocketbaseHelper.pb
        .collection(collection)
        .getFirstListItem('user_id = "$user_id"');

    final doctor = Doctor.fromJson(result.toJson());

    return doctor;
  }

  Future<Doctor?> updateDoctorProfileById(
    String id,
    String key,
    String value,
  ) async {
    final result = await PocketbaseHelper.pb.collection(collection).update(
      id,
      body: {
        key: value,
      },
    );

    final doctor = Doctor.fromJson(result.toJson());

    return doctor;
  }

  Future<Doctor?> updateDoctorAvatarAndLogo({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    try {
      final updateDoctorResponse =
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

      final doc = Doctor.fromJson(
        updateDoctorResponse.toJson(),
      );

      return doc;
    } catch (e) {
      rethrow;
    }
  }
}
