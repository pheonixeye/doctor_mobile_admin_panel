// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ArticleParagraph extends Equatable {
  final String id;
  final String article_id;
  final String title_en;
  final String title_ar;
  final String body_en;
  final String body_ar;

  const ArticleParagraph({
    required this.id,
    required this.article_id,
    required this.title_en,
    required this.title_ar,
    required this.body_en,
    required this.body_ar,
  });

  ArticleParagraph copyWith({
    String? id,
    String? article_id,
    String? title_en,
    String? title_ar,
    String? body_en,
    String? body_ar,
  }) {
    return ArticleParagraph(
      id: id ?? this.id,
      article_id: article_id ?? this.article_id,
      title_en: title_en ?? this.title_en,
      title_ar: title_ar ?? this.title_ar,
      body_en: body_en ?? this.body_en,
      body_ar: body_ar ?? this.body_ar,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'article_id': article_id,
      'title_en': title_en,
      'title_ar': title_ar,
      'body_en': body_en,
      'body_ar': body_ar,
    };
  }

  factory ArticleParagraph.fromJson(Map<String, dynamic> map) {
    return ArticleParagraph(
      id: map['id'] as String,
      article_id: map['article_id'] as String,
      title_en: map['title_en'] as String,
      title_ar: map['title_ar'] as String,
      body_en: map['body_en'] as String,
      body_ar: map['body_ar'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      article_id,
      title_en,
      title_ar,
      body_en,
      body_ar,
    ];
  }

  static Map<String, String> editableStrings(BuildContext context) {
    return {
      'title_en': context.loc.englishTitle,
      'title_ar': context.loc.arabicTitle,
      'body_en': context.loc.englishBody,
      'body_ar': context.loc.arabicBody,
    };
  }
}
