// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SocialContact extends Equatable {
  final String id;
  final String doc_id;
  final String main_phone;
  final String main_wa;
  final String fb;
  final String ig;
  final String yt;
  final String li;

  const SocialContact({
    required this.id,
    required this.doc_id,
    required this.main_phone,
    required this.main_wa,
    required this.fb,
    required this.ig,
    required this.yt,
    required this.li,
  });

  SocialContact copyWith({
    String? id,
    String? doc_id,
    String? main_phone,
    String? main_wa,
    String? fb,
    String? ig,
    String? yt,
    String? li,
  }) {
    return SocialContact(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      main_phone: main_phone ?? this.main_phone,
      main_wa: main_wa ?? this.main_wa,
      fb: fb ?? this.fb,
      ig: ig ?? this.ig,
      yt: yt ?? this.yt,
      li: li ?? this.li,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'main_phone': main_phone,
      'main_wa': main_wa,
      'fb': fb,
      'ig': ig,
      'yt': yt,
      'li': li,
    };
  }

  factory SocialContact.fromJson(Map<String, dynamic> map) {
    return SocialContact(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      main_phone: map['main_phone'] as String,
      main_wa: map['main_wa'] as String,
      fb: map['fb'] as String,
      ig: map['ig'] as String,
      yt: map['yt'] as String,
      li: map['li'] as String,
    );
  }

  factory SocialContact.withDocId(String doc_id) {
    return SocialContact(
      id: '',
      doc_id: doc_id,
      main_phone: '',
      main_wa: '',
      fb: '',
      ig: '',
      yt: '',
      li: '',
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      doc_id,
      main_phone,
      main_wa,
      fb,
      ig,
      yt,
      li,
    ];
  }

  static Map<String, String> editableFields(BuildContext context) => {
        'main_phone': context.loc.mainPhone,
        'main_wa': context.loc.mainWa,
        'fb': context.loc.fb,
        'ig': context.loc.ig,
        'yt': context.loc.yt,
        'li': context.loc.li,
      };
}
