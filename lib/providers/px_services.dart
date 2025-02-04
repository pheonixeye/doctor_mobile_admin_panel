import 'package:doctor_mobile_admin_panel/api/services_api/services_api.dart';
import 'package:doctor_mobile_admin_panel/models/service.dart';
import 'package:doctor_mobile_admin_panel/models/service_response_model.dart';
import 'package:flutter/material.dart';

class PxServices extends ChangeNotifier {
  final HxServices servicesService;

  PxServices({required this.servicesService}) {
    _fetchServices();
  }

  static List<ServiceResponseModel>? _services;
  List<ServiceResponseModel>? get services => _services;

  Future<void> _fetchServices() async {
    _services = await servicesService.fetchOneDoctorServices();
    notifyListeners();
  }

  Future<void> createService(Service service) async {
    await servicesService.createService(service);
    await _fetchServices();
  }

  Future<void> deleteService(String id) async {
    await servicesService.deleteService(id);
    await _fetchServices();
  }

  Future<void> updateServiceData(Service service) async {
    await servicesService.updateServiceData(service);
    await _fetchServices();
  }
}
