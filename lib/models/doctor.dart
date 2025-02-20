// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  final List<String>? clinic_ids;
  final List<String>? about_ids;
  final List<String>? video_ids;
  final List<String>? article_ids;
  final List<String>? hero_items_ids;
  final List<String>? services_ids;
  final List<String>? cases_ids;
  final String avatar;
  final String logo;
  final String? site_settings_id;
  final String? social_contacts_id;

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
    required this.services_ids,
    required this.cases_ids,
    required this.avatar,
    required this.logo,
    required this.site_settings_id,
    required this.social_contacts_id,
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
    List<String>? services_ids,
    List<String>? cases_ids,
    String? avatar,
    String? logo,
    String? site_settings_id,
    String? social_contacts_id,
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
      services_ids: services_ids ?? this.services_ids,
      cases_ids: cases_ids ?? this.cases_ids,
      avatar: avatar ?? this.avatar,
      logo: logo ?? this.logo,
      site_settings_id: site_settings_id ?? this.site_settings_id,
      social_contacts_id: social_contacts_id ?? this.social_contacts_id,
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
      'services_ids': services_ids,
      'cases_ids': cases_ids,
      'avatar': avatar,
      'logo': logo,
      'site_settings_id': site_settings_id,
      'social_contacts_id': social_contacts_id,
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
      clinic_ids:
          List<String>.from((map['clinic_ids'] as List<dynamic>? ?? [])),
      about_ids: List<String>.from((map['about_ids'] as List<dynamic>? ?? [])),
      video_ids: List<String>.from((map['video_ids'] as List<dynamic>? ?? [])),
      article_ids:
          List<String>.from((map['article_ids'] as List<dynamic>? ?? [])),
      hero_items_ids:
          List<String>.from((map['hero_items_ids'] as List<dynamic>? ?? [])),
      services_ids:
          List<String>.from((map['services_ids'] as List<dynamic>? ?? [])),
      cases_ids: List<String>.from((map['cases_ids'] as List<dynamic>? ?? [])),
      avatar: map['avatar'] as String,
      logo: map['logo'] as String,
      site_settings_id: map['site_settings_id'] as String?,
      social_contacts_id: map['social_contacts_id'] as String?,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
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
      services_ids,
      cases_ids,
      avatar,
      logo,
      site_settings_id,
      social_contacts_id,
    ];
  }

  static Map<String, String> doctorEditableFields(BuildContext context) => {
        'name_en': context.loc.englishName,
        'name_ar': context.loc.arabicName,
        'title_en': context.loc.englishTitle,
        'title_ar': context.loc.arabicTitle,
        'prefix_en': context.loc.englishPrefix,
        'prefix_ar': context.loc.arabicPrefix,
        'avatar': context.loc.avatar,
        'logo': context.loc.logo,
      };
}
