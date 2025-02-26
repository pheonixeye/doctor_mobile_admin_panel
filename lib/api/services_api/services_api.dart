import 'dart:typed_data';

import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/extensions/annotations.dart';
// import 'package:doctor_mobile_admin_panel/functions/pretty_json.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:doctor_mobile_admin_panel/models/faq.dart';
import 'package:doctor_mobile_admin_panel/models/service.dart';
import 'package:doctor_mobile_admin_panel/models/service_response_model.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ServicesApi {
  const ServicesApi();

  static final DataSourceHelper _helper = DataSourceHelper();

  Future<List<ServiceResponseModel>?> fetchOneDoctorServices();
  Future<ServiceResponseModel> createService(Service service);
  Future<void> updateServiceData(
      String service_id, Map<String, dynamic> update);
  Future<void> deleteService(String service_id);
  Future<void> updateServiceImage({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  });
  Future<void> addServiceFaq(Faq faq);
  Future<void> deleteServiceFaq(String faq_id);

  factory ServicesApi.common({required String doc_id}) {
    return switch (_helper.dataSource) {
      DataSource.pb => HxServicesPocketbase(doc_id: doc_id),
      DataSource.sb => HxServicesSupabase(doc_id: doc_id),
    };
  }
}

@POCKETBASE()
class HxServicesPocketbase extends ServicesApi {
  const HxServicesPocketbase({required this.doc_id});

  final String doc_id;

  static const String collection = 'services';
  static const String _expand = 'faq_ids';

  @override
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

  @override
  Future<ServiceResponseModel> createService(Service service) async {
    final result = await PocketbaseHelper.pb.collection(collection).create(
          body: service.toJson(),
          expand: _expand,
        );

    final _doctorQueryResult = await PocketbaseHelper.pb
        .collection(HxProfilePocketbase.collection)
        .getFirstListItem('id = "${service.doc_id}"');

    final _doctor = Doctor.fromJson(_doctorQueryResult.toJson());

    final _update = {
      'services_ids': [
        ..._doctor.services_ids ?? [],
        result.id,
      ],
    };

    await PocketbaseHelper.pb.collection(HxProfilePocketbase.collection).update(
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

  @override
  Future<void> updateServiceData(
    String service_id,
    Map<String, dynamic> update,
  ) async {
    await PocketbaseHelper.pb.collection(collection).update(
          service_id,
          body: update,
          expand: _expand,
        );
  }

  @override
  Future<void> deleteService(String service_id) async {
    await PocketbaseHelper.pb.collection(collection).delete(
          service_id,
        );
  }

  @override
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

  @override
  Future<void> addServiceFaq(Faq faq) async {
    final result = await PocketbaseHelper.pb.collection(faqsCollection).create(
          body: faq.toJson(),
        );

    final _ServiceQueryResult = await PocketbaseHelper.pb
        .collection(collection)
        .getFirstListItem('id = "${faq.service_id}"');

    final service = Service.fromJson(_ServiceQueryResult.toJson());

    final _update = {
      'faq_ids': [
        ...service.faq_ids ?? [],
        result.id,
      ],
    };

    await PocketbaseHelper.pb.collection(collection).update(
          faq.service_id,
          body: _update,
          expand: _expand,
        );

    // final _serviceResponseModel = ServiceResponseModel(
    //   service: Service.fromJson(_serviceUpdateResult.toJson()),
    //   faqs: _serviceUpdateResult
    //       .get<List<RecordModel>>('expand.faq_ids')
    //       .map((e) => Faq.fromJson(e.toJson()))
    //       .toList(),
    // );

    // return _serviceResponseModel;
  }

  @override
  Future<void> deleteServiceFaq(String faq_id) async {
    await PocketbaseHelper.pb.collection(faqsCollection).delete(faq_id);
  }
}

@SUPABASE()
class HxServicesSupabase extends ServicesApi {
  HxServicesSupabase({required this.doc_id});

  final String doc_id;

  static const String collection = 'services';

  static const String _faqsCollection = 'faqs';

  final _client = (DataSourceHelper.ds as SupabaseClient);

  @override
  Future<ServiceResponseModel> createService(Service service) async {
    final _result = await _client
        .from(collection)
        .insert(service.toSupabaseJson())
        .select();

    return ServiceResponseModel(
      service: Service.fromJson(_result.first),
      faqs: [],
    );
  }

  @override
  Future<void> deleteService(String service_id) async {
    await _client.from(collection).delete().eq('id', service_id);
  }

  @override
  Future<List<ServiceResponseModel>?> fetchOneDoctorServices() async {
    final rpc = 'get_services';

    final _params = {'doctor_id': doc_id};

    final _result = await _client.rpc(rpc, params: _params).select();

    // dprint(_result);
    return _result.map((x) {
      return ServiceResponseModel(
        service: Service.fromJson(x),
        faqs: (x['faqs'] as List<dynamic>? ?? [])
            .map((y) => Faq.fromJson(y))
            .toList(),
      );
    }).toList();
  }

  @override
  Future<void> updateServiceData(
    String service_id,
    Map<String, dynamic> update,
  ) async {
    await _client.from(collection).update(update).eq('id', service_id);
  }

  @override
  Future<void> updateServiceImage({
    required String id, //service_id
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    final _data = Uint8List.fromList(fileBytes);
    // final _file = File.fromRawPath(_data);
    //TODO: change for mobile
    final result = await _client.storage.from('base').uploadBinary(
          '$doc_id/$collection/$id/$fileName_key',
          _data,
          fileOptions: const FileOptions(
            cacheControl: '3600',
            upsert: true,
          ),
        );

    String _pathDebased = result.replaceFirstMapped('base/', (m) => '');

    final _update = {
      'image': _pathDebased,
    };

    await _client.from(collection).update(_update).eq('id', id);
  }

  @override
  Future<void> addServiceFaq(Faq faq) async {
    await _client.from(_faqsCollection).insert(
          faq.toSupabaseJson(),
          defaultToNull: false,
        );
  }

  @override
  Future<void> deleteServiceFaq(String faq_id) async {
    await _client.from(_faqsCollection).delete().eq('id', faq_id);
  }
}
