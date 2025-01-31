// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final String id;
  final String doc_id;
  final String name_en;
  final String name_ar;
  final String description_en;
  final String description_ar;
  final List<String> faq_ids;
  final String image;

  const Service({
    required this.id,
    required this.doc_id,
    required this.name_en,
    required this.name_ar,
    required this.description_en,
    required this.description_ar,
    required this.faq_ids,
    required this.image,
  });

  Service copyWith({
    String? id,
    String? doc_id,
    String? name_en,
    String? name_ar,
    String? description_en,
    String? description_ar,
    List<String>? faq_ids,
    String? image,
  }) {
    return Service(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      name_en: name_en ?? this.name_en,
      name_ar: name_ar ?? this.name_ar,
      description_en: description_en ?? this.description_en,
      description_ar: description_ar ?? this.description_ar,
      faq_ids: faq_ids ?? this.faq_ids,
      image: image ?? this.image,
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
      'faq_ids': faq_ids,
      'image': image,
    };
  }

  factory Service.fromJson(Map<String, dynamic> map) {
    return Service(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      name_en: map['name_en'] as String,
      name_ar: map['name_ar'] as String,
      description_en: map['description_en'] as String,
      description_ar: map['description_ar'] as String,
      faq_ids: List<String>.from((map['faq_ids'] as List<dynamic>)),
      image: map['image'] as String,
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
      faq_ids,
      image,
    ];
  }
}
