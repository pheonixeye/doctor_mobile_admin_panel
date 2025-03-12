// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String id;
  final String doc_id;
  final String? clinic_id;
  final String? schedule_id;
  final String? date;
  final String? name;
  final String? phone;

  const Booking({
    required this.id,
    required this.doc_id,
    required this.clinic_id,
    required this.schedule_id,
    required this.date,
    required this.name,
    required this.phone,
  });

  Booking copyWith({
    String? id,
    String? doc_id,
    String? clinic_id,
    String? schedule_id,
    String? date,
    String? name,
    String? phone,
  }) {
    return Booking(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      clinic_id: clinic_id ?? this.clinic_id,
      schedule_id: schedule_id ?? this.schedule_id,
      date: date ?? this.date,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'clinic_id': clinic_id,
      'schedule_id': schedule_id,
      'date': date,
      'name': name,
      'phone': phone,
    };
  }

  Map<String, dynamic> toSupabaseJson() {
    return toJson()..remove('id');
  }

  factory Booking.fromJson(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      clinic_id: map['clinic_id'] as String?,
      schedule_id: map['schedule_id'] as String?,
      date: map['date'] as String?,
      name: map['name'] as String?,
      phone: map['phone'] as String?,
    );
  }

  factory Booking.empty(String doc_id) {
    return Booking(
      id: '',
      doc_id: doc_id,
      clinic_id: '',
      schedule_id: '',
      date: '',
      name: '',
      phone: '',
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      doc_id,
      clinic_id,
      schedule_id,
      date,
      name,
      phone,
    ];
  }
}
