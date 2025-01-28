// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:doctor_mobile_admin_panel/models/clinic.dart';
import 'package:doctor_mobile_admin_panel/models/schedule.dart';
import 'package:equatable/equatable.dart';

class ClinicResponseModel extends Equatable {
  final Clinic clinic;
  final List<Schedule> schedule;
  final List<String> offDates;
  const ClinicResponseModel({
    required this.clinic,
    required this.schedule,
    required this.offDates,
  });

  ClinicResponseModel copyWith({
    Clinic? clinic,
    List<Schedule>? schedule,
    List<String>? offDates,
  }) {
    return ClinicResponseModel(
      clinic: clinic ?? this.clinic,
      schedule: schedule ?? this.schedule,
      offDates: offDates ?? this.offDates,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'clinic': clinic.toJson(),
      'schedule': schedule.map((x) => x.toJson()).toList(),
      'offDates': offDates,
    };
  }

  factory ClinicResponseModel.fromJson(Map<String, dynamic> map) {
    return ClinicResponseModel(
        clinic: Clinic.fromJson(map['clinic'] as Map<String, dynamic>),
        schedule: List<Schedule>.from(
            (map['schedule'] as List<dynamic>).map<Schedule>(
          (x) => Schedule.fromJson(x as Map<String, dynamic>),
        )),
        offDates: List<String>.from(
          (map['offDates'] as List<String>),
        ));
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        clinic,
        schedule,
        offDates,
      ];
}
