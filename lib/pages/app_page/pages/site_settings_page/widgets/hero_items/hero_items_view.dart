import 'package:doctor_mobile_admin_panel/components/central_loading.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/site_settings_page/widgets/hero_items/hero_item_view_edit_card.dart';
import 'package:doctor_mobile_admin_panel/providers/px_hero_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeroItemsView extends StatelessWidget {
  const HeroItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PxHeroItems>(
      builder: (context, h, _) {
        while (h.items == null) {
          return const CentralLoading();
        }
        return ListView(
          cacheExtent: 3000,
          children: [
            ListTile(
              leading: const CircleAvatar(),
              title: Text(context.loc.heroItems),
              subtitle: const Divider(),
            ),
            ...h.items!.map((item) {
              return HeroItemViewEditCard(item: item);
            })
          ],
        );
      },
    );
  }
}
