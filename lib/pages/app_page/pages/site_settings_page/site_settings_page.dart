import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/hero_item.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/site_settings_page/widgets/hero_items/create_hero_item_dialog.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/site_settings_page/widgets/hero_items/hero_items_view.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/site_settings_page/widgets/site_settings/site_settings_view.dart';
import 'package:doctor_mobile_admin_panel/providers/px_hero_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SiteSettingsPage extends StatefulWidget {
  const SiteSettingsPage({super.key});

  @override
  State<SiteSettingsPage> createState() => _SiteSettingsPageState();
}

class _SiteSettingsPageState extends State<SiteSettingsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: context.loc.siteSettings,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.web_asset),
            label: context.loc.heroItems,
          ),
        ],
        onTap: (value) {
          setState(() {
            _tabController.animateTo(value);
          });
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          SiteSettingsView(),
          HeroItemsView(),
        ],
      ),
      floatingActionButton: _tabController.index == 1
          ? FloatingActionButton(
              heroTag: 'add-hero-item',
              onPressed: () async {
                final _heroItem = await showDialog<HeroItem?>(
                  context: context,
                  builder: (context) {
                    return const CreateHeroItemDialog();
                  },
                );
                if (_heroItem == null) {
                  return;
                }
                if (context.mounted) {
                  await shellFunction(
                    context,
                    toExecute: () async {
                      await context
                          .read<PxHeroItems>()
                          .createHeroItem(_heroItem);
                    },
                  );
                }
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
