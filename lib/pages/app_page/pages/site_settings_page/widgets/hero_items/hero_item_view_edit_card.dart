import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/models/hero_item.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/site_settings_page/widgets/hero_items/hero_item_edit_item.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/site_settings_page/widgets/hero_items/hero_item_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:doctor_mobile_admin_panel/extensions/hero_item_ext.dart';

class HeroItemViewEditCard extends StatefulWidget {
  const HeroItemViewEditCard({super.key, required this.item});
  final HeroItem item;

  @override
  State<HeroItemViewEditCard> createState() => _HeroItemViewEditCardState();
}

class _HeroItemViewEditCardState extends State<HeroItemViewEditCard> {
  late Map<String, TextEditingController> _controllers;
  late Map<String, bool> _isEditing;
  @override
  void didChangeDependencies() {
    _isEditing = Map.fromEntries(
      widget.item.toJson().entries.map(
            (entry) => MapEntry<String, bool>(
              entry.key,
              false,
            ),
          ),
    );
    _controllers = Map.fromEntries(
      widget.item.toJson().entries.map(
            (entry) => MapEntry<String, TextEditingController>(
              entry.key,
              TextEditingController(),
            ),
          ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      elevation: 0,
      child: ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.item.title_en),
            Text(widget.item.title_ar),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card.outlined(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
              elevation: 0,
              child: ExpansionTile(
                title: Text(context.loc.heroTitle),
                children: [
                  ...widget.item.titleOptions(context).entries.map((entry) {
                    return HeroItemEditItem(
                      item: widget.item,
                      entry: entry,
                      isEditing: _isEditing[entry.key]!,
                      controller: _controllers[entry.key]!,
                      alignKey: 't_align',
                    );
                  })
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card.outlined(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
              elevation: 0,
              child: ExpansionTile(
                title: Text(context.loc.heroSubitle),
                children: [
                  ...widget.item.subtitleOptions(context).entries.map((entry) {
                    return HeroItemEditItem(
                      item: widget.item,
                      entry: entry,
                      isEditing: _isEditing[entry.key]!,
                      controller: _controllers[entry.key]!,
                      alignKey: 's_align',
                    );
                  })
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card.outlined(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
              elevation: 0,
              child: ExpansionTile(
                title: Text(context.loc.heroDescription),
                children: [
                  ...widget.item
                      .descriptionOptions(context)
                      .entries
                      .map((entry) {
                    return HeroItemEditItem(
                      item: widget.item,
                      entry: entry,
                      isEditing: _isEditing[entry.key]!,
                      controller: _controllers[entry.key]!,
                      alignKey: 'd_align',
                    );
                  })
                ],
              ),
            ),
          ),
          HeroItemImagePicker(
            title: context.loc.heroImageMobile,
            item: widget.item,
            imageKey: 'image_mobile',
          ),
          HeroItemImagePicker(
            title: context.loc.heroImageOther,
            item: widget.item,
            imageKey: 'image_other',
          ),
        ],
      ),
    );
  }
}
