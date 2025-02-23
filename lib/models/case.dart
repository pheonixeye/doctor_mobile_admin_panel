// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Case extends Equatable {
  final String id;
  final String doc_id;
  final String name_en;
  final String name_ar;
  final String description_en;
  final String description_ar;
  final String pre_image;
  final String post_image;

  const Case({
    required this.id,
    required this.doc_id,
    required this.name_en,
    required this.name_ar,
    required this.description_en,
    required this.description_ar,
    required this.pre_image,
    required this.post_image,
  });

  Case copyWith({
    String? id,
    String? doc_id,
    String? name_en,
    String? name_ar,
    String? description_en,
    String? description_ar,
    String? pre_image,
    String? post_image,
  }) {
    return Case(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      name_en: name_en ?? this.name_en,
      name_ar: name_ar ?? this.name_ar,
      description_en: description_en ?? this.description_en,
      description_ar: description_ar ?? this.description_ar,
      pre_image: pre_image ?? this.pre_image,
      post_image: post_image ?? this.post_image,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'name_en': name_en,
      'name_ar': name_ar,
      'description_en': description_en,
      'description_ar': description_ar,
      'pre_image': pre_image,
      'post_image': post_image,
    };
  }

  Map<String, dynamic> toSupabaseJson() {
    return toJson()..remove('id');
  }

  factory Case.fromJson(Map<String, dynamic> map) {
    return Case(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      name_en: map['name_en'] as String,
      name_ar: map['name_ar'] as String,
      description_en: map['description_en'] as String,
      description_ar: map['description_ar'] as String,
      pre_image: map['pre_image'] as String,
      post_image: map['post_image'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      doc_id,
      name_en,
      name_ar,
      description_en,
      description_ar,
      pre_image,
      post_image,
    ];
  }

  static Map<String, String> editableStrings(BuildContext context) {
    return {
      'name_en': context.loc.englishName,
      'name_ar': context.loc.arabicName,
      'description_en': context.loc.englishDescription,
      'description_ar': context.loc.arabicDescription,
      'pre_image': context.loc.preImage,
      'post_image': context.loc.postImage,
    };
  }
}
