import 'package:doctor_mobile_admin_panel/localization/app_localizations.dart';
import 'package:doctor_mobile_admin_panel/providers/_px_main.dart';
import 'package:doctor_mobile_admin_panel/providers/locale_p.dart';
import 'package:doctor_mobile_admin_panel/providers/px_theme.dart';
import 'package:doctor_mobile_admin_panel/router/router.dart';
import 'package:doctor_mobile_admin_panel/theme/app_theme.dart';
import 'package:doctor_mobile_admin_panel/utils/util_keys.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ar');

  runApp(const ApplicationProvider());
}

class ApplicationProvider extends StatelessWidget {
  const ApplicationProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxLocale, PxTheme>(
      builder: (context, l, t, _) {
        return MaterialApp.router(
          scaffoldMessengerKey: scaffoldKey,
          title: 'Admin Panel',
          debugShowCheckedModeBanner: false,
          //THEMES
          theme: AppTheme.theme(
            colorScheme: const ColorScheme.light(
              primary: Colors.blueGrey,
            ),
          ),
          darkTheme: AppTheme.theme(
            colorScheme: const ColorScheme.dark(
              primary: Colors.blueGrey,
            ),
            textTheme: const TextTheme().apply(
              displayColor: Colors.white,
              bodyColor: Colors.white,
            ),
          ),
          themeMode: t.mode,
          routerConfig: AppRouter.instance().router,
          locale: l.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
