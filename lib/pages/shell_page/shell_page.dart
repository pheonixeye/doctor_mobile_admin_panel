import 'package:doctor_mobile_admin_panel/components/end_drawer.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:flutter/material.dart';

class ShellPage extends StatelessWidget {
  const ShellPage({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.adminPanel),
        centerTitle: true,
      ),
      drawer: EndDrawer(),
      body: child,
    );
  }
}
