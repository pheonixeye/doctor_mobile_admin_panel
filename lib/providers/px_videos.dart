import 'package:doctor_mobile_admin_panel/api/videos_api/videos_api.dart';
import 'package:doctor_mobile_admin_panel/models/video.dart';
import 'package:flutter/material.dart';

class PxVideos extends ChangeNotifier {
  final VideosApi service;

  PxVideos({required this.service}) {
    _fetchAllDoctorVideos();
  }

  static List<Video>? _videos;
  List<Video>? get videos => _videos;

  Future<void> _fetchAllDoctorVideos() async {
    _videos = await service.fetchAllDoctorVideos();
    notifyListeners();
  }

  Future<void> createVideo(Video video) async {
    await service.createVideo(video);
    await _fetchAllDoctorVideos();
  }

  Future<void> updateVideoData(String id, Map<String, dynamic> update) async {
    await service.updateVideo(id, update);
    await _fetchAllDoctorVideos();
  }

  Future<void> updateVideoThumbnail({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    await service.updateVideoThumbnail(
      id: id,
      fileBytes: fileBytes,
      fileName_key: fileName_key,
    );
    await _fetchAllDoctorVideos();
  }

  Future<void> deleteVideo(String id) async {
    await service.deleteVideo(id);
    await _fetchAllDoctorVideos();
  }
}
