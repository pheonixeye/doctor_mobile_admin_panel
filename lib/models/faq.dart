// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Faq extends Equatable {
  final String id;
  final String service_id;
  final String q_en;
  final String q_ar;
  final String a_en;
  final String a_ar;
  final String? video_id;

  const Faq({
    required this.id,
    required this.service_id,
    required this.q_en,
    required this.q_ar,
    required this.a_en,
    required this.a_ar,
    required this.video_id,
  });

  Faq copyWith({
    String? id,
    String? service_id,
    String? q_en,
    String? q_ar,
    String? a_en,
    String? a_ar,
    String? video_id,
  }) {
    return Faq(
      id: id ?? this.id,
      service_id: service_id ?? this.service_id,
      q_en: q_en ?? this.q_en,
      q_ar: q_ar ?? this.q_ar,
      a_en: a_en ?? this.a_en,
      a_ar: a_ar ?? this.a_ar,
      video_id: video_id ?? this.video_id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'service_id': service_id,
      'q_en': q_en,
      'q_ar': q_ar,
      'a_en': a_en,
      'a_ar': a_ar,
      'video_id': video_id,
    };
  }

  Map<String, dynamic> toSupabaseJson() {
    return toJson()
      ..remove('id')
      ..remove('video_id');
  }

  factory Faq.fromJson(Map<String, dynamic> map) {
    return Faq(
      id: map['id'] as String,
      service_id: map['service_id'] as String,
      q_en: map['q_en'] as String,
      q_ar: map['q_ar'] as String,
      a_en: map['a_en'] as String,
      a_ar: map['a_ar'] as String,
      video_id: map['video_id'] as String?,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      service_id,
      q_en,
      q_ar,
      a_en,
      a_ar,
      video_id,
    ];
  }
}
