// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:doctor_mobile_admin_panel/models/faq.dart';
import 'package:doctor_mobile_admin_panel/models/service.dart';
import 'package:equatable/equatable.dart';

class ServiceResponseModel extends Equatable {
  final Service serivce;
  final List<Faq> faqs;

  const ServiceResponseModel({
    required this.serivce,
    required this.faqs,
  });

  ServiceResponseModel copyWith({
    Service? serivce,
    List<Faq>? faqs,
  }) {
    return ServiceResponseModel(
      serivce: serivce ?? this.serivce,
      faqs: faqs ?? this.faqs,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [serivce, faqs];
}
