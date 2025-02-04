import 'package:doctor_mobile_admin_panel/components/drawer_nav_btn.dart';
import 'package:doctor_mobile_admin_panel/components/thin_divider.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:doctor_mobile_admin_panel/providers/px_theme.dart';
import 'package:doctor_mobile_admin_panel/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8.0,
      backgroundColor: Colors.blueGrey.shade500.withValues(alpha: 0.9),
      child: Consumer<GoRouteInformationProvider>(
        builder: (context, r, _) {
          bool selected(String path) => r.value.uri.path.endsWith('/$path');
          return ListView(
            children: [
              const SizedBox(height: 20),
              //navigation
              const ThinDivider(),
              DrawerNavBtn(
                title: context.loc.bookings,
                icondata: Icons.today,
                routePath: AppRouter.app,
                selected: selected(AppRouter.app),
              ),
              const ThinDivider(),
              DrawerNavBtn(
                title: context.loc.profile,
                icondata: Icons.person,
                routePath: AppRouter.profile,
                selected: selected(AppRouter.profile),
              ),
              const ThinDivider(),
              DrawerNavBtn(
                title: context.loc.clinics,
                icondata: Icons.local_hospital,
                routePath: AppRouter.clinics,
                selected: selected(AppRouter.clinics),
              ),
              const ThinDivider(),
              DrawerNavBtn(
                title: context.loc.articles,
                icondata: Icons.article,
                routePath: AppRouter.articles,
                selected: selected(AppRouter.articles),
              ),
              const ThinDivider(),
              DrawerNavBtn(
                title: context.loc.services,
                icondata: Icons.home_repair_service_rounded,
                routePath: AppRouter.services,
                selected: selected(AppRouter.services),
              ),
              const ThinDivider(),
              //theme && language(TODO: maybe change location in settings page)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: Colors.white),
                  ),
                  mouseCursor: SystemMouseCursors.click,
                  onTap: () async {
                    await shellFunction(
                      context,
                      toExecute: () async {
                        if (context.mounted) {
                          await context.read<PxTheme>().changeThemeMode();
                        }
                      },
                    );
                  },
                  title: Row(
                    children: [
                      const SizedBox(width: 5),
                      CircleAvatar(
                        radius: 18,
                        child: Icon(
                          Icons.theater_comedy,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        context.loc.theme,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const ThinDivider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: Colors.white),
                  ),
                  mouseCursor: SystemMouseCursors.click,
                  onTap: () async {
                    await shellFunction(
                      context,
                      toExecute: () async {
                        if (context.mounted) {
                          await context.read<PxLocale>().changeLocale();
                        }
                      },
                    );
                  },
                  title: Row(
                    children: [
                      const SizedBox(width: 5),
                      CircleAvatar(
                        radius: 18,
                        child: Icon(
                          Icons.language,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        context.loc.language,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const ThinDivider(),
            ],
          );
        },
      ),
    );
  }
}
