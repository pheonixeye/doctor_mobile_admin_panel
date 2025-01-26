import 'package:doctor_mobile_admin_panel/api/app_user_api/app_user_api.dart';
import 'package:doctor_mobile_admin_panel/providers/px_local_db.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:doctor_mobile_admin_panel/providers/px_app_users.dart';
import 'package:doctor_mobile_admin_panel/providers/px_theme.dart';
import 'package:doctor_mobile_admin_panel/router/router.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider.value(
    value: AppRouter.router.routeInformationProvider,
  ),
  ChangeNotifierProvider(create: (context) => PxLocalDatabase.instance),
  ChangeNotifierProvider(create: (context) => PxLocale(context)),
  ChangeNotifierProvider(create: (context) => PxTheme(context)),
  ChangeNotifierProvider(
    create: (context) => PxAppUsers(
      userService: HxAppUsers(),
    ),
  ),
];
