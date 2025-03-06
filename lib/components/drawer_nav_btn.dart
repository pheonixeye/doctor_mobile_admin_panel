import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DrawerNavBtn extends StatelessWidget {
  const DrawerNavBtn({
    super.key,
    this.routePath,
    required this.title,
    this.icondata,
    this.selected = false,
  });
  final String? routePath;
  final String title;
  final IconData? icondata;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Consumer<PxLocale>(
      builder: (context, l, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: Colors.white),
            ),
            mouseCursor: SystemMouseCursors.click,
            onTap: () {
              GoRouter.of(context).goNamed(routePath!);
              Scaffold.of(context).closeDrawer();
            },
            // selectedColor: AppTheme.secondaryOrangeColor,
            selectedTileColor: Theme.of(context).primaryColor,
            selected: selected,
            title: Row(
              children: [
                const SizedBox(width: 5),
                CircleAvatar(
                  radius: 18,
                  child: icondata == null
                      ? const SizedBox()
                      : Icon(
                          icondata,
                          size: selected ? 22 : 18,
                          // color:
                          // selected ? AppTheme.secondaryOrangeColor : null,
                        ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: selected ? 16 : 14,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
