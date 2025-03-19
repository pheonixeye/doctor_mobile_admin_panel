import 'package:doctor_mobile_admin_panel/constants/constants.dart';
import 'package:doctor_mobile_admin_panel/firebase_options.dart';
import 'package:doctor_mobile_admin_panel/localization/app_localizations.dart';
import 'package:doctor_mobile_admin_panel/providers/_px_main.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:doctor_mobile_admin_panel/providers/px_theme.dart';
import 'package:doctor_mobile_admin_panel/router/router.dart';
import 'package:doctor_mobile_admin_panel/theme/app_theme.dart';
import 'package:doctor_mobile_admin_panel/utils/util_keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting('ar');

  await dotenv.load(fileName: "/env/.env");

  await Supabase.initialize(
    url: dotenv.env[AppConstants.SUPABASE_URL]!,
    anonKey: dotenv.env[AppConstants.SUPABASE_ANON_KEY]!,
  );

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
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: t.mode,
          routerConfig: AppRouter.router,
          locale: l.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
