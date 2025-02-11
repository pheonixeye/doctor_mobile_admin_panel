import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/models/article.dart';
import 'package:doctor_mobile_admin_panel/models/case.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:doctor_mobile_admin_panel/models/service.dart';
import 'package:doctor_mobile_admin_panel/models/video.dart';

String _baseUrl({
  required String collection,
  required String id,
  required String fileKey,
}) {
  return "${PocketbaseHelper.pb.baseURL}/api/files/$collection/$id/$fileKey?thumb=200x200";
}

extension ImageUrlExtractorDoctor on Doctor {
  String? imageUrl(String fileKey) => avatar.isEmpty
      ? null
      : _baseUrl(collection: 'doctors', id: id, fileKey: fileKey);
}

extension ImageUrlExtractorService on Service {
  String? imageUrl(String fileKey) => image.isEmpty
      ? null
      : _baseUrl(collection: 'services', id: id, fileKey: fileKey);
}

extension ImageUrlExtractorVideo on Video {
  String? imageUrl(String fileKey) => thumbnail.isEmpty
      ? null
      : _baseUrl(collection: 'videos', id: id, fileKey: fileKey);
}

extension ImageUrlExtractorCase on Case {
  String? imageUrlPre(String fileKey) => pre_image.isEmpty
      ? null
      : _baseUrl(collection: 'cases', id: id, fileKey: fileKey);

  String? imageUrlPost(String fileKey) => post_image.isEmpty
      ? null
      : _baseUrl(collection: 'cases', id: id, fileKey: fileKey);
}

extension ImageUrlExtractorArticle on Article {
  String? imageUrl(String fileKey) => thumbnail.isEmpty
      ? null
      : _baseUrl(collection: 'articles', id: id, fileKey: fileKey);
}
