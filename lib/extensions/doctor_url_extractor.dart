import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';

extension ImageUrlExtractor on Doctor {
  String? imageUrl(String fileKey) => avatar.isEmpty
      ? null
      : "${PocketbaseHelper.pb.baseURL}/api/files/doctors/$id/$fileKey?thumb=200x200";
}
