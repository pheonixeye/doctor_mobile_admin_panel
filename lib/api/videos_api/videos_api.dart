import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:doctor_mobile_admin_panel/models/video.dart';
import 'package:http/http.dart' as http;

class HxVideos {
  const HxVideos({required this.doc_id});

  static const String collection = 'videos';

  final String doc_id;

  Future<Video> createVideo(Video video) async {
    final _result = await PocketbaseHelper.pb.collection(collection).create(
          body: video.toJson(),
        );
    final _doctorRef = await PocketbaseHelper.pb
        .collection(HxProfile.collection)
        .getOne(doc_id);

    final doctor = Doctor.fromJson(_doctorRef.toJson());

    final _update = {
      'video_ids': [
        ...doctor.video_ids,
        _result.id,
      ],
    };

    await PocketbaseHelper.pb.collection(HxProfile.collection).update(
          doc_id,
          body: _update,
        );

    return Video.fromJson(_result.toJson());
  }

  Future<Video> updateVideo(
    String id,
    Map<String, dynamic> update,
  ) async {
    final _result = await PocketbaseHelper.pb.collection(collection).update(
          id,
          body: update,
        );
    return Video.fromJson(_result.toJson());
  }

  Future<void> deleteVideo(String id) async {
    await PocketbaseHelper.pb.collection(collection).delete(id);
  }

  Future<Video> updateVideoThumbnail({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    try {
      final _result = await PocketbaseHelper.pb.collection(collection).update(
        id,
        files: [
          http.MultipartFile.fromBytes(
            fileName_key,
            fileBytes,
            filename: fileName_key,
          ),
        ],
      );

      return Video.fromJson(_result.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Video>> fetchAllDoctorVideos() async {
    //TODO: add pagination
    final _result = await PocketbaseHelper.pb
        .collection(collection)
        .getList(filter: 'doc_id = "$doc_id"');

    return _result.items.map((e) => Video.fromJson(e.toJson())).toList();
  }
}
