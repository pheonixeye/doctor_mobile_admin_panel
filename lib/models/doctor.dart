// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String id;
  final String user_id;
  final String name_en;
  final String name_ar;
  final String spec_en;
  final String spec_ar;
  final String title_en;
  final String title_ar;
  final String prefix_en;
  final String prefix_ar;
  final List<String> clinic_ids;
  final List<String> about_ids;
  final List<String> video_ids;
  final List<String> article_ids;
  final List<String> hero_items_ids;
  final String avatar;
  final String logo;

  const Doctor({
    required this.id,
    required this.user_id,
    required this.name_en,
    required this.name_ar,
    required this.spec_en,
    required this.spec_ar,
    required this.title_en,
    required this.title_ar,
    required this.prefix_en,
    required this.prefix_ar,
    required this.clinic_ids,
    required this.about_ids,
    required this.video_ids,
    required this.article_ids,
    required this.hero_items_ids,
    required this.avatar,
    required this.logo,
  });

  Doctor copyWith({
    String? id,
    String? user_id,
    String? name_en,
    String? name_ar,
    String? spec_en,
    String? spec_ar,
    String? title_en,
    String? title_ar,
    String? prefix_en,
    String? prefix_ar,
    List<String>? clinic_ids,
    List<String>? about_ids,
    List<String>? video_ids,
    List<String>? article_ids,
    List<String>? hero_items_ids,
    String? avatar,
    String? logo,
  }) {
    return Doctor(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      name_en: name_en ?? this.name_en,
      name_ar: name_ar ?? this.name_ar,
      spec_en: spec_en ?? this.spec_en,
      spec_ar: spec_ar ?? this.spec_ar,
      title_en: title_en ?? this.title_en,
      title_ar: title_ar ?? this.title_ar,
      prefix_en: prefix_en ?? this.prefix_en,
      prefix_ar: prefix_ar ?? this.prefix_ar,
      clinic_ids: clinic_ids ?? this.clinic_ids,
      about_ids: about_ids ?? this.about_ids,
      video_ids: video_ids ?? this.video_ids,
      article_ids: article_ids ?? this.article_ids,
      hero_items_ids: hero_items_ids ?? this.hero_items_ids,
      avatar: avatar ?? this.avatar,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'name_en': name_en,
      'name_ar': name_ar,
      'spec_en': spec_en,
      'spec_ar': spec_ar,
      'title_en': title_en,
      'title_ar': title_ar,
      'prefix_en': prefix_en,
      'prefix_ar': prefix_ar,
      'clinic_ids': clinic_ids,
      'about_ids': about_ids,
      'video_ids': video_ids,
      'article_ids': article_ids,
      'hero_items_ids': hero_items_ids,
      'avatar': avatar,
      'logo': logo,
    };
  }

  factory Doctor.fromJson(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] as String,
      user_id: map['user_id'] as String,
      name_en: map['name_en'] as String,
      name_ar: map['name_ar'] as String,
      spec_en: map['spec_en'] as String,
      spec_ar: map['spec_ar'] as String,
      title_en: map['title_en'] as String,
      title_ar: map['title_ar'] as String,
      prefix_en: map['prefix_en'] as String,
      prefix_ar: map['prefix_ar'] as String,
      clinic_ids: List<String>.from((map['clinic_ids'] as List<dynamic>)),
      about_ids: List<String>.from((map['about_ids'] as List<dynamic>)),
      video_ids: List<String>.from((map['video_ids'] as List<dynamic>)),
      article_ids: List<String>.from((map['article_ids'] as List<dynamic>)),
      hero_items_ids:
          List<String>.from((map['hero_items_ids'] as List<dynamic>)),
      avatar: map['avatar'] as String,
      logo: map['logo'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      user_id,
      name_en,
      name_ar,
      spec_en,
      spec_ar,
      title_en,
      title_ar,
      prefix_en,
      prefix_ar,
      clinic_ids,
      about_ids,
      video_ids,
      article_ids,
      hero_items_ids,
      avatar,
      logo,
    ];
  }
}
