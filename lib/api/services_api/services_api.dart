import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:doctor_mobile_admin_panel/models/faq.dart';
import 'package:doctor_mobile_admin_panel/models/service.dart';
import 'package:doctor_mobile_admin_panel/models/service_response_model.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

class HxServices {
  const HxServices(this.doc_id);

  final String doc_id;

  static const String collection = 'services';
  static const String _expand = 'faq_ids';

  Future<List<ServiceResponseModel>?> fetchOneDoctorServices() async {
    final result = await PocketbaseHelper.pb.collection(collection).getList(
          filter: 'doc_id = "$doc_id"',
          expand: _expand,
        );

    final _services = result.items.map((e) {
      return ServiceResponseModel(
        service: Service.fromJson(e.toJson()),
        faqs: e
            .get<List<RecordModel>>('expand.faq_ids')
            .map((e) => Faq.fromJson(e.toJson()))
            .toList(),
      );
    }).toList();

    return _services;
  }

  Future<ServiceResponseModel> createService(Service service) async {
    final result = await PocketbaseHelper.pb.collection(collection).create(
          body: service.toJson(),
          expand: _expand,
        );

    final _doctorQueryResult = await PocketbaseHelper.pb
        .collection(HxProfile.collection)
        .getFirstListItem('id = "${service.doc_id}"');

    final _doctor = Doctor.fromJson(_doctorQueryResult.toJson());

    final _update = {
      'services_ids': [
        ..._doctor.services_ids,
        result.id,
      ],
    };

    await PocketbaseHelper.pb.collection(HxProfile.collection).update(
          service.doc_id,
          body: _update,
        );

    final _serviceResponseModel = ServiceResponseModel(
      service: Service.fromJson(result.toJson()),
      faqs: result
          .get<List<RecordModel>>('expand.faq_ids')
          .map((e) => Faq.fromJson(e.toJson()))
          .toList(),
    );

    return _serviceResponseModel;
  }

  Future<void> updateServiceData(Service service) async {
    await PocketbaseHelper.pb.collection(collection).update(
          service.id,
          body: service.toJson(),
          expand: _expand,
        );
  }

  Future<void> deleteService(String service_id) async {
    await PocketbaseHelper.pb.collection(collection).delete(
          service_id,
        );
  }

  Future<void> updateServiceImage({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    await PocketbaseHelper.pb.collection(collection).update(
      id,
      files: [
        http.MultipartFile.fromBytes(
          fileName_key,
          fileBytes,
          filename: fileName_key,
        ),
      ],
    );
  }

  static const String faqsCollection = 'faqs';

  Future<ServiceResponseModel> addServiceFaq(Faq faq) async {
    final result = await PocketbaseHelper.pb.collection(faqsCollection).create(
          body: faq.toJson(),
        );

    final _ServiceQueryResult = await PocketbaseHelper.pb
        .collection(collection)
        .getFirstListItem(faq.service_id);

    final service = Service.fromJson(_ServiceQueryResult.toJson());

    final _update = {
      'faq_ids': [
        ...service.faq_ids,
        result.id,
      ],
    };

    final _serviceUpdateResult =
        await PocketbaseHelper.pb.collection(collection).update(
              faq.service_id,
              body: _update,
              expand: _expand,
            );

    final _serviceResponseModel = ServiceResponseModel(
      service: Service.fromJson(_serviceUpdateResult.toJson()),
      faqs: _serviceUpdateResult
          .get<List<RecordModel>>('expand.faq_ids')
          .map((e) => Faq.fromJson(e.toJson()))
          .toList(),
    );

    return _serviceResponseModel;
  }
}
