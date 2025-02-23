import 'package:doctor_mobile_admin_panel/api/services_api/services_api.dart';
import 'package:doctor_mobile_admin_panel/models/faq.dart';
import 'package:doctor_mobile_admin_panel/models/service.dart';
import 'package:doctor_mobile_admin_panel/models/service_response_model.dart';
import 'package:flutter/material.dart';

class PxServices extends ChangeNotifier {
  final ServicesApi servicesService;

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

  Future<void> updateServiceData(
    String service_id,
    Map<String, dynamic> update,
  ) async {
    await servicesService.updateServiceData(service_id, update);
    await _fetchServices();
  }

  Future<void> addServiceFaq(Faq faq) async {
    await servicesService.addServiceFaq(faq);
    await _fetchServices();
  }

  Future<void> deleteServiceFaq(String faq_id) async {
    await servicesService.deleteServiceFaq(faq_id);
    await _fetchServices();
  }

  Future<void> addServiceImage({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    await servicesService.updateServiceImage(
      id: id,
      fileBytes: fileBytes,
      fileName_key: fileName_key,
    );
    await _fetchServices();
  }
}
