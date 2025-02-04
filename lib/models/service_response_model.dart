// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:doctor_mobile_admin_panel/models/faq.dart';
import 'package:doctor_mobile_admin_panel/models/service.dart';
import 'package:equatable/equatable.dart';

class ServiceResponseModel extends Equatable {
  final Service service;
  final List<Faq> faqs;

  const ServiceResponseModel({
    required this.service,
    required this.faqs,
  });

  ServiceResponseModel copyWith({
    Service? service,
    List<Faq>? faqs,
  }) {
    return ServiceResponseModel(
      service: service ?? this.service,
      faqs: faqs ?? this.faqs,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [service, faqs];
}
