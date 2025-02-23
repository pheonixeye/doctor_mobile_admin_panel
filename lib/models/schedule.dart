// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:doctor_mobile_admin_panel/models/weekdays_model.dart';
import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final String id;
  final String clinic_id;
  final String weekday_en;
  final String weekday_ar;
  final int intday;
  final int start_min;
  final int start_hour;
  final int end_min;
  final int end_hour;
  final bool available;

  const Schedule({
    required this.id,
    required this.clinic_id,
    required this.weekday_en,
    required this.weekday_ar,
    required this.intday,
    required this.start_min,
    required this.start_hour,
    required this.end_min,
    required this.end_hour,
    required this.available,
  });

  Schedule copyWith({
    String? id,
    String? clinic_id,
    String? weekday_en,
    String? weekday_ar,
    int? intday,
    int? start_min,
    int? start_hour,
    int? end_min,
    int? end_hour,
    bool? available,
  }) {
    return Schedule(
      id: id ?? this.id,
      clinic_id: clinic_id ?? this.clinic_id,
      weekday_en: weekday_en ?? this.weekday_en,
      weekday_ar: weekday_ar ?? this.weekday_ar,
      intday: intday ?? this.intday,
      start_min: start_min ?? this.start_min,
      start_hour: start_hour ?? this.start_hour,
      end_min: end_min ?? this.end_min,
      end_hour: end_hour ?? this.end_hour,
      available: available ?? this.available,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'clinic_id': clinic_id,
      'weekday_en': weekday_en,
      'weekday_ar': weekday_ar,
      'intday': intday,
      'start_min': start_min,
      'start_hour': start_hour,
      'end_min': end_min,
      'end_hour': end_hour,
      'available': available,
    };
  }

  Map<String, dynamic> toSupabaseJson() {
    return toJson()..remove('id');
  }

  factory Schedule.fromJson(Map<String, dynamic> map) {
    return Schedule(
      id: map['id'] as String,
      clinic_id: map['clinic_id'] as String,
      weekday_en: map['weekday_en'] as String,
      weekday_ar: map['weekday_ar'] as String,
      intday: map['intday'] as int,
      start_min: map['start_min'] as int,
      start_hour: map['start_hour'] as int,
      end_min: map['end_min'] as int,
      end_hour: map['end_hour'] as int,
      available: map['available'] as bool,
    );
  }

  factory Schedule.empty() {
    return Schedule(
      id: '',
      clinic_id: '',
      weekday_en: Weekday.WEEKDAYS.first.weekdayEn,
      weekday_ar: Weekday.WEEKDAYS.first.weekdayAr,
      intday: Weekday.WEEKDAYS.first.intDay,
      start_min: 0,
      start_hour: 0,
      end_min: 0,
      end_hour: 0,
      available: true,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      clinic_id,
      weekday_en,
      weekday_ar,
      intday,
      start_min,
      start_hour,
      end_min,
      end_hour,
      available,
    ];
  }
}
