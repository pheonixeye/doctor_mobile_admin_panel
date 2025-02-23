// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class DoctorAbout extends Equatable {
  final String id;
  final String doc_id;
  final String about_en;
  final String about_ar;

  const DoctorAbout({
    required this.id,
    required this.doc_id,
    required this.about_en,
    required this.about_ar,
  });

  DoctorAbout copyWith({
    String? id,
    String? doc_id,
    String? about_en,
    String? about_ar,
  }) {
    return DoctorAbout(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      about_en: about_en ?? this.about_en,
      about_ar: about_ar ?? this.about_ar,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'about_en': about_en,
      'about_ar': about_ar,
    };
  }

  Map<String, dynamic> toSupabaseJson() {
    return toJson()..remove('id');
  }

  factory DoctorAbout.fromJson(Map<String, dynamic> map) {
    return DoctorAbout(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      about_en: map['about_en'] as String,
      about_ar: map['about_ar'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        doc_id,
        about_en,
        about_ar,
      ];
}
