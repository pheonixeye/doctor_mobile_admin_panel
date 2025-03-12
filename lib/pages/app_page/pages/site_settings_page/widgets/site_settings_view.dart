import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:flutter/material.dart';

class SiteSettingsView extends StatelessWidget {
  const SiteSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      cacheExtent: 3000,
      children: [
        ListTile(
          leading: const CircleAvatar(),
          title: Text(context.loc.siteSettings),
          subtitle: const Divider(),
        ),
      ],
    );
  }
}
