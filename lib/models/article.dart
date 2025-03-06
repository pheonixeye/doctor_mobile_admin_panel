// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Article extends Equatable {
  final String id;
  final String doc_id;
  final String title_en;
  final String title_ar;
  final String description_en;
  final String description_ar;
  final String thumbnail;
  final List<String>? paragraphs_ids;

  const Article({
    required this.id,
    required this.doc_id,
    required this.title_en,
    required this.title_ar,
    required this.description_en,
    required this.description_ar,
    required this.thumbnail,
    this.paragraphs_ids,
  });

  Article copyWith({
    String? id,
    String? doc_id,
    String? title_en,
    String? title_ar,
    String? description_en,
    String? description_ar,
    String? thumbnail,
    List<String>? paragraphs_ids,
  }) {
    return Article(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      title_en: title_en ?? this.title_en,
      title_ar: title_ar ?? this.title_ar,
      description_en: description_en ?? this.description_en,
      description_ar: description_ar ?? this.description_ar,
      thumbnail: thumbnail ?? this.thumbnail,
      paragraphs_ids: paragraphs_ids ?? this.paragraphs_ids,
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
      'thumbnail': thumbnail,
      'paragraphs_ids': paragraphs_ids,
    };
  }

  Map<String, dynamic> toSupabaseJson() {
    return toJson()
      ..remove('id')
      ..remove('paragraphs_ids');
  }

  factory Article.fromJson(Map<String, dynamic> map) {
    return Article(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      title_en: map['title_en'] as String,
      title_ar: map['title_ar'] as String,
      description_en: map['description_en'] as String,
      description_ar: map['description_ar'] as String,
      thumbnail: map['thumbnail'] as String,
      // paragraphs_ids: map['paragraphs_ids'] == null
      //     ? []
      //     : List<String>.from((map['paragraphs_ids'] as List<dynamic>)),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      doc_id,
      title_en,
      title_ar,
      description_en,
      description_ar,
      thumbnail,
      paragraphs_ids,
    ];
  }

  static Map<String, String> editableStrings(BuildContext context) {
    return {
      'title_en': context.loc.englishTitle,
      'title_ar': context.loc.arabicTitle,
      'description_en': context.loc.englishDescription,
      'description_ar': context.loc.arabicDescription,
      'thumbnail': context.loc.articleThumbnail,
    };
  }
}
