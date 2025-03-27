// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Clinic extends Equatable {
  final String id;
  final String name_en;
  final String name_ar;
  final String address_en;
  final String address_ar;
  final String phone;
  final String wa;
  final String location_link;
  final String doc_id;
  final List<String>? schedule_ids;
  final List<String>? off_dates;
  final String? image;

  const Clinic({
    required this.id,
    required this.name_en,
    required this.name_ar,
    required this.address_en,
    required this.address_ar,
    required this.phone,
    required this.wa,
    required this.location_link,
    required this.doc_id,
    required this.schedule_ids,
    required this.off_dates,
    required this.image,
  });

  Clinic copyWith({
    String? id,
    String? name_en,
    String? name_ar,
    String? address_en,
    String? address_ar,
    String? phone,
    String? wa,
    String? location_link,
    String? doc_id,
    List<String>? schedule_ids,
    List<String>? off_dates,
    String? image,
  }) {
    return Clinic(
      id: id ?? this.id,
      name_en: name_en ?? this.name_en,
      name_ar: name_ar ?? this.name_ar,
      address_en: address_en ?? this.address_en,
      address_ar: address_ar ?? this.address_ar,
      phone: phone ?? this.phone,
      wa: wa ?? this.wa,
      location_link: location_link ?? this.location_link,
      doc_id: doc_id ?? this.doc_id,
      schedule_ids: schedule_ids ?? this.schedule_ids,
      off_dates: off_dates ?? this.off_dates,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name_en': name_en,
      'name_ar': name_ar,
      'address_en': address_en,
      'address_ar': address_ar,
      'phone': phone,
      'wa': wa,
      'location_link': location_link,
      'doc_id': doc_id,
      'schedule_ids': schedule_ids,
      'off_dates': off_dates,
      'image': image,
    };
  }

  Map<String, dynamic> toSupabaseJson() {
    return toJson()
      ..remove('id')
      ..remove('schedule_ids')
      ..remove('off_dates');
  }

  factory Clinic.fromJson(Map<String, dynamic> map) {
    return Clinic(
      id: map['id'] as String,
      name_en: map['name_en'] as String,
      name_ar: map['name_ar'] as String,
      address_en: map['address_en'] as String,
      address_ar: map['address_ar'] as String,
      phone: map['phone'] as String,
      wa: map['wa'] as String,
      location_link: map['location_link'] as String,
      doc_id: map['doc_id'] as String,
      schedule_ids:
          List<String>.from((map['schedule_ids'] as List<dynamic>? ?? [])),
      off_dates: List<String>.from((map['off_dates'] as List<dynamic>? ?? [])),
      image: map['image'] as String?,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name_en,
      name_ar,
      address_en,
      address_ar,
      phone,
      wa,
      location_link,
      doc_id,
      schedule_ids,
      off_dates,
      image,
    ];
  }

  static Map<String, String> clinicEditableFields(BuildContext context) => {
        'name_en': context.loc.englishName,
        'name_ar': context.loc.arabicName,
        'address_en': context.loc.englishAddress,
        'address_ar': context.loc.arabicAddress,
        'phone': context.loc.phone,
        'wa': context.loc.whatsapp,
        'location_link': context.loc.locationLink,
        'image': context.loc.clinicImage,
      };
}
