import 'dart:typed_data';

import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/models/hero_item.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

abstract class HeroItemsApi {
  HeroItemsApi();

  static final DataSourceHelper _helper = DataSourceHelper();

  Future<List<HeroItem>> fetchDoctorHeroItems();
  Future<HeroItem> createHeroItem(HeroItem heroItem);
  Future<void> deleteHeroItem(String id);
  Future<void> updateHeroItem(String id, Map<String, dynamic> update);
  Future<void> updateHeroItemImage({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  });

  factory HeroItemsApi.common(String doc_id) {
    return switch (_helper.dataSource) {
      DataSource.pb => HxHeroItemsPocketbase(doc_id: doc_id),
      DataSource.sb => HxHeroItemsSupabase(doc_id: doc_id),
    };
  }
}

class HxHeroItemsPocketbase extends HeroItemsApi {
  HxHeroItemsPocketbase({required this.doc_id});

  final String doc_id;

  static const String collection = 'hero_items';

  final _client = DataSourceHelper.ds as PocketBase;

  @override
  Future<HeroItem> createHeroItem(HeroItem heroItem) async {
    final _result =
        await _client.collection(collection).create(body: heroItem.toJson());
    return HeroItem.fromJson(_result.data);
  }

  @override
  Future<void> deleteHeroItem(String id) async {
    await _client.collection(collection).delete(id);
  }

  @override
  Future<List<HeroItem>> fetchDoctorHeroItems() async {
    final _result = await _client
        .collection(collection)
        .getList(filter: 'doc_id = "$doc_id"');

    return _result.items.map((e) => HeroItem.fromJson(e.toJson())).toList();
  }

  @override
  Future<void> updateHeroItem(String id, Map<String, dynamic> update) async {
    await _client.collection(collection).update(id, body: update);
  }

  @override
  Future<void> updateHeroItemImage({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    try {
      await _client.collection(collection).update(
        doc_id,
        files: [
          http.MultipartFile.fromBytes(
            fileName_key,
            fileBytes,
            filename: fileName_key,
          ),
        ],
      );
    } catch (e) {
      rethrow;
    }
  }
}

class HxHeroItemsSupabase extends HeroItemsApi {
  HxHeroItemsSupabase({required this.doc_id});

  final String doc_id;

  static const String collection = 'hero_items';

  final _client = DataSourceHelper.ds as SupabaseClient;

  @override
  Future<HeroItem> createHeroItem(HeroItem heroItem) async {
    final _result = await _client
        .from(collection)
        .insert(heroItem.toSupabaseJson())
        .select();

    return HeroItem.fromJson(_result.first);
  }

  @override
  Future<void> deleteHeroItem(String id) async {
    await _client.from(collection).delete().eq('id', id);
  }

  @override
  Future<List<HeroItem>> fetchDoctorHeroItems() async {
    final _result =
        await _client.from(collection).select().eq('doc_id', doc_id);
    return _result.map(HeroItem.fromJson).toList();
  }

  @override
  Future<void> updateHeroItem(String id, Map<String, dynamic> update) async {
    await _client.from(collection).update(update).eq('id', id);
  }

  @override
  Future<void> updateHeroItemImage({
    required String id,
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
      fileName_key: _pathDebased,
    };

    await _client.from(collection).update(_update).eq('id', id);
  }
}
