import 'package:doctor_mobile_admin_panel/pages/app_page/app_page.dart';
import 'package:doctor_mobile_admin_panel/pages/loading_screen/loading_screen.dart';
import 'package:doctor_mobile_admin_panel/pages/login_page/login_page.dart';
import 'package:doctor_mobile_admin_panel/pages/shell_page/shell_page.dart';
import 'package:doctor_mobile_admin_panel/utils/util_keys.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static AppRouter get _instance => AppRouter._();

  factory AppRouter.instance() => _instance;

  static const String app = 'app';

  final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'loading',
        builder: (context, state) {
          return LoadingScreen(
            key: state.pageKey,
          );
        },
        routes: [
          GoRoute(
            path: 'login',
            name: 'login',
            builder: (context, state) {
              return LoginPage(
                key: state.pageKey,
              );
            },
          ),
          ShellRoute(
            builder: (context, state, child) {
              return ShellPage(
                key: state.pageKey,
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: app,
                name: app,
                builder: (context, state) {
                  return AppPage(
                    key: state.pageKey,
                  );
                },
                routes: [],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
