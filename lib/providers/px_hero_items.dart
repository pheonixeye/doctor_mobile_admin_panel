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
}
