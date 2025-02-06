// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String id;
  final String doc_id;
  final String title_en;
  final String title_ar;
  final String description_en;
  final String description_ar;
  final String src;
  final String thumbnail;
  final bool is_long;

  const Video({
    required this.id,
    required this.doc_id,
    required this.title_en,
    required this.title_ar,
    required this.description_en,
    required this.description_ar,
    required this.src,
    required this.thumbnail,
    required this.is_long,
  });

  Video copyWith({
    String? id,
    String? doc_id,
    String? title_en,
    String? title_ar,
    String? description_en,
    String? description_ar,
    String? src,
    String? thumbnail,
    bool? is_long,
  }) {
    return Video(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      title_en: title_en ?? this.title_en,
      title_ar: title_ar ?? this.title_ar,
      description_en: description_en ?? this.description_en,
      description_ar: description_ar ?? this.description_ar,
      src: src ?? this.src,
      thumbnail: thumbnail ?? this.thumbnail,
      is_long: is_long ?? this.is_long,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'title_en': title_en,
      'title_ar': title_ar,
      'description_en': description_en,
      'description_ar': description_ar,
      'src': src,
      'thumbnail': thumbnail,
      'is_long': is_long,
    };
  }

  factory Video.fromJson(Map<String, dynamic> map) {
    return Video(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      title_en: map['title_en'] as String,
      title_ar: map['title_ar'] as String,
      description_en: map['description_en'] as String,
      description_ar: map['description_ar'] as String,
      src: map['src'] as String,
      thumbnail: map['thumbnail'] as String,
      is_long: map['is_long'] as bool,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      doc_id,
      title_en,
      title_ar,
      description_en,
      description_ar,
      src,
      thumbnail,
      is_long,
    ];
  }
}
