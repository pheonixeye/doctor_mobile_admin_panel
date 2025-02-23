import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/models/article.dart';
import 'package:doctor_mobile_admin_panel/models/case.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:doctor_mobile_admin_panel/models/service.dart';
import 'package:doctor_mobile_admin_panel/models/video.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

String _baseUrlPocketbase({
  required String collection,
  required String id,
  required String fileKey,
}) {
  final _url =
      "${(DataSourceHelper.ds as PocketBase).baseURL}/api/files/$collection/$id/$fileKey?thumb=200x200";
  // print(_url);
  return _url;
}

String _baseUrlSupabase({
  required String collection,
  required String id,
  required String fileKey,
}) {
  final _url = (DataSourceHelper.ds as SupabaseClient)
      .storage
      .from(collection)
      .getPublicUrl(fileKey);
  // print(_url);
  return _url;
}

extension ImageUrlExtractorDoctor on Doctor {
  String? imageUrlByKey(String fileKey) => fileKey.isEmpty
      ? null
      : switch (DataSourceHelper().dataSource) {
          DataSource.pb => _baseUrlPocketbase(
              collection: 'doctors',
              id: id,
              fileKey: fileKey,
            ),
          DataSource.sb => _baseUrlSupabase(
              collection: 'base',
              id: id,
              fileKey: fileKey,
            ),
        };
}

extension ImageUrlExtractorService on Service {
  String? imageUrl(String fileKey) => fileKey.isEmpty
      ? null
      : switch (DataSourceHelper().dataSource) {
          DataSource.pb => _baseUrlPocketbase(
              collection: 'services',
              id: id,
              fileKey: fileKey,
            ),
          DataSource.sb => _baseUrlSupabase(
              collection: 'base',
              id: id,
              fileKey: fileKey,
            ),
        };
}

extension ImageUrlExtractorVideo on Video {
  String? imageUrl(String fileKey) => thumbnail.isEmpty
      ? null
      : _baseUrlPocketbase(collection: 'videos', id: id, fileKey: fileKey);
}

extension ImageUrlExtractorCase on Case {
  String? imageUrlPre(String fileKey) => pre_image.isEmpty
      ? null
      : _baseUrlPocketbase(collection: 'cases', id: id, fileKey: fileKey);

  String? imageUrlPost(String fileKey) => post_image.isEmpty
      ? null
      : _baseUrlPocketbase(collection: 'cases', id: id, fileKey: fileKey);
}

extension ImageUrlExtractorArticle on Article {
  String? imageUrl(String fileKey) => thumbnail.isEmpty
      ? null
      : _baseUrlPocketbase(collection: 'articles', id: id, fileKey: fileKey);
}
