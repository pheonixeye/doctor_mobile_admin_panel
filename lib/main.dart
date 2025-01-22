import 'package:doctor_mobile_admin_panel/localization/app_localizations.dart';
import 'package:doctor_mobile_admin_panel/providers/_px_main.dart';
import 'package:doctor_mobile_admin_panel/providers/locale_p.dart';
import 'package:doctor_mobile_admin_panel/router/router.dart';
import 'package:doctor_mobile_admin_panel/theme/theme.dart';
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
    return Consumer<PxLocale>(
      builder: (context, l, _) {
        return MaterialApp.router(
          title: 'Admin Panel',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          themeMode: ThemeMode.system,
          darkTheme: AppTheme.dark,
          routerConfig: AppRouter.instance().router,
          locale: l.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
