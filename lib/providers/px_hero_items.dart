import 'package:doctor_mobile_admin_panel/api/hero_items_api/hero_items_api.dart';
import 'package:doctor_mobile_admin_panel/models/hero_item.dart';
import 'package:flutter/material.dart';

class PxHeroItems extends ChangeNotifier {
  final HeroItemsApi service;

  PxHeroItems({required this.service}) {
    _fetchItems();
  }

  static List<HeroItem>? _items;
  List<HeroItem>? get items => _items;

  Future<void> _fetchItems() async {
    _items = await service.fetchDoctorHeroItems();
    notifyListeners();
  }

  Future<void> createHeroItem(HeroItem heroItem) async {
    await service.createHeroItem(heroItem);
    await _fetchItems();
  }

  Future<void> updateHeroItem(String id, Map<String, dynamic> update) async {
    await service.updateHeroItem(id, update);
    await _fetchItems();
  }

  Future<void> updateHeroItemImage({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    await service.updateHeroItemImage(
      id: id,
      fileBytes: fileBytes,
      fileName_key: fileName_key,
    );

    await _fetchItems();
  }

  Future<void> deleteHeroItem(String id) async {
    await service.deleteHeroItem(id);
    await _fetchItems();
  }
}
