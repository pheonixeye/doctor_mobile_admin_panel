import 'dart:typed_data';

import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/extensions/annotations.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:doctor_mobile_admin_panel/models/video.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class VideosApi {
  const VideosApi();

  static final DataSourceHelper _helper = DataSourceHelper();

  Future<Video> createVideo(Video video);
  Future<Video> updateVideo(String id, Map<String, dynamic> update);
  Future<void> deleteVideo(String id);
  Future<void> updateVideoThumbnail({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  });
  Future<List<Video>> fetchAllDoctorVideos();

  factory VideosApi.common({required String doc_id}) {
    return switch (_helper.dataSource) {
      DataSource.pb => HxVideosPocketbase(doc_id: doc_id),
      DataSource.sb => HxVideosSupabase(doc_id: doc_id),
    };
  }
}

@POCKETBASE()
class HxVideosPocketbase extends VideosApi {
  HxVideosPocketbase({required this.doc_id});

  static const String collection = 'videos';

  final String doc_id;

  final _client = (DataSourceHelper.ds as PocketBase);

  @override
  Future<Video> createVideo(Video video) async {
    final _result = await _client.collection(collection).create(
          body: video.toJson(),
        );
    final _doctorRef =
        await _client.collection(HxProfilePocketbase.collection).getOne(doc_id);

    final doctor = Doctor.fromJson(_doctorRef.toJson());

    final _update = {
      'video_ids': [
        ...doctor.video_ids ?? [],
        _result.id,
      ],
    };

    await _client.collection(HxProfilePocketbase.collection).update(
          doc_id,
          body: _update,
        );

    return Video.fromJson(_result.toJson());
  }

  @override
  Future<Video> updateVideo(
    String id,
    Map<String, dynamic> update,
  ) async {
    final _result = await _client.collection(collection).update(
          id,
          body: update,
        );
    return Video.fromJson(_result.toJson());
  }

  @override
  Future<void> deleteVideo(String id) async {
    await _client.collection(collection).delete(id);
  }

  @override
  Future<Video> updateVideoThumbnail({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    try {
      final _result = await _client.collection(collection).update(
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

  @override
  Future<List<Video>> fetchAllDoctorVideos() async {
    //TODO: add pagination
    final _result = await _client
        .collection(collection)
        .getList(filter: 'doc_id = "$doc_id"');

    return _result.items.map((e) => Video.fromJson(e.toJson())).toList();
  }
}

@SUPABASE()
class HxVideosSupabase extends VideosApi {
  final String doc_id;

  HxVideosSupabase({required this.doc_id});

  final _client = (DataSourceHelper.ds as SupabaseClient);

  static const String collection = 'videos';

  @override
  Future<Video> createVideo(Video video) async {
    final _result =
        await _client.from(collection).insert(video.toSupabaseJson()).select();
    return Video.fromJson(_result.first);
  }

  @override
  Future<void> deleteVideo(String id) async {
    await _client.from(collection).delete().eq('id', id);
  }

  @override
  Future<List<Video>> fetchAllDoctorVideos() async {
    final _result =
        await _client.from(collection).select().eq('doc_id', doc_id);
    return _result.map((e) => Video.fromJson(e)).toList();
  }

  @override
  Future<Video> updateVideo(String id, Map<String, dynamic> update) async {
    final _result =
        await _client.from(collection).update(update).eq('id', id).select();
    return Video.fromJson(_result.first);
  }

  @override
  Future<void> updateVideoThumbnail({
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
      'thumbnail': _pathDebased,
    };

    await _client.from(collection).update(_update).eq('id', id);
  }
}
