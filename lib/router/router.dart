import 'package:doctor_mobile_admin_panel/api/articles_api/articles_api.dart';
import 'package:doctor_mobile_admin_panel/api/cases_api/cases_api.dart';
import 'package:doctor_mobile_admin_panel/api/clinics_api/clinics_api.dart';
import 'package:doctor_mobile_admin_panel/api/doctor_about_api.dart/doctor_about_api.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/api/services_api/services_api.dart';
import 'package:doctor_mobile_admin_panel/api/social_contacts_api/social_contacts_api.dart';
import 'package:doctor_mobile_admin_panel/api/videos_api/videos_api.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/app_page.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/articles_page/articles_page.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/cases_page/cases_page.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/clinics_page/clinics_page.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/profile_page/profile_page.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/services_page/services_page.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/site_settings_page/site_settings_page.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/social_contacts_page/social_contacts_page.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/videos_page/videos_page.dart';
import 'package:doctor_mobile_admin_panel/pages/loading_screen/loading_screen.dart';
import 'package:doctor_mobile_admin_panel/pages/login_page/login_page.dart';
import 'package:doctor_mobile_admin_panel/pages/shell_page/shell_page.dart';
import 'package:doctor_mobile_admin_panel/providers/px_app_users.dart';
import 'package:doctor_mobile_admin_panel/providers/px_articles.dart';
import 'package:doctor_mobile_admin_panel/providers/px_cases.dart';
import 'package:doctor_mobile_admin_panel/providers/px_clinics.dart';
import 'package:doctor_mobile_admin_panel/providers/px_doctor_about.dart';
import 'package:doctor_mobile_admin_panel/providers/px_profile.dart';
import 'package:doctor_mobile_admin_panel/providers/px_services.dart';
import 'package:doctor_mobile_admin_panel/providers/px_social_contact.dart';
import 'package:doctor_mobile_admin_panel/providers/px_videos.dart';
import 'package:doctor_mobile_admin_panel/utils/util_keys.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static const String loading = '/';
  static const String login = 'login';
  static const String app = 'app'; //bookings
  static const String profile = 'profile';
  static const String clinics = 'clinics';
  static const String articles = 'articles';
  static const String services = 'services';
  static const String cases = 'cases';
  static const String videos = 'videos';
  static const String social_contacts = 'social_contacts';
  static const String site_settings = 'site_settings';

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: loading,
    routes: [
      GoRoute(
        path: loading,
        name: loading,
        builder: (context, state) {
          return LoadingScreen(
            key: state.pageKey,
          );
        },
        routes: [
          GoRoute(
            path: login,
            name: login,
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
              //bookings
              GoRoute(
                path: app,
                name: app,
                builder: (context, state) {
                  return AppPage(
                    key: state.pageKey,
                  );
                },
                routes: [
                  GoRoute(
                    path: profile,
                    name: profile,
                    builder: (context, state) {
                      final _doc_id = context.read<PxAppUsers>().doc_id;
                      final _key = ValueKey('$_doc_id/${state.pageKey.value}');
                      return MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (context) => PxProfile(
                              profileService:
                                  ProfileApi.common(doc_id: _doc_id ?? ''),
                            ),
                          ),
                          ChangeNotifierProvider(
                            create: (context) => PxDoctorAbout(
                              service:
                                  DoctorAboutApi.common(doc_id: _doc_id ?? ''),
                            ),
                          ),
                        ],
                        child: ProfilePage(
                          key: _key,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: clinics,
                    name: clinics,
                    builder: (context, state) {
                      final doc_id = context.read<PxAppUsers>().doc_id;
                      final _key = ValueKey('$doc_id/${state.pageKey.value}');
                      // dprintPretty(_key.value);
                      return ChangeNotifierProvider(
                        create: (context) => PxClinics(
                          clinicsService:
                              ClinicsApi.common(doc_id: doc_id ?? ''),
                        ),
                        child: ClinicsPage(
                          key: _key,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: articles,
                    name: articles,
                    builder: (context, state) {
                      final doc_id = context.read<PxAppUsers>().doc_id;
                      final _key = ValueKey('$doc_id/${state.pageKey.value}');
                      return ChangeNotifierProvider(
                        create: (context) => PxArticles(
                            service: HxArticles(doc_id: doc_id ?? '')),
                        child: ArticlesPage(
                          key: _key,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: cases,
                    name: cases,
                    builder: (context, state) {
                      final doc_id = context.read<PxAppUsers>().doc_id;
                      final _key = ValueKey('$doc_id/${state.pageKey.value}');
                      return ChangeNotifierProvider(
                        create: (context) => PxCases(
                            service: CasesApi.common(doc_id: doc_id ?? '')),
                        child: CasesPage(
                          key: _key,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: videos,
                    name: videos,
                    builder: (context, state) {
                      final doc_id = context.read<PxAppUsers>().doc_id;
                      final _key = ValueKey('$doc_id/${state.pageKey.value}');
                      return ChangeNotifierProvider(
                        create: (context) => PxVideos(
                          service: VideosApi.common(doc_id: doc_id ?? ''),
                        ),
                        child: VideosPage(
                          key: _key,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: social_contacts,
                    name: social_contacts,
                    builder: (context, state) {
                      final doc_id = context.read<PxAppUsers>().doc_id;
                      final _key = ValueKey('$doc_id/${state.pageKey.value}');
                      return ChangeNotifierProvider(
                        create: (context) => PxSocialContact(
                          socialContactsService: HxSocialContacts(
                            doc_id: doc_id ?? '',
                          ),
                        ),
                        child: SocialContactsPage(
                          key: _key,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: site_settings,
                    name: site_settings,
                    builder: (context, state) {
                      return SiteSettingsPage(
                        key: state.pageKey,
                      );
                    },
                  ),
                  GoRoute(
                    path: services,
                    name: services,
                    builder: (context, state) {
                      final doc_id = context.read<PxAppUsers>().doc_id;
                      final _key = ValueKey('$doc_id/${state.pageKey.value}');
                      return ChangeNotifierProvider(
                        create: (context) => PxServices(
                          servicesService:
                              ServicesApi.common(doc_id: doc_id ?? ''),
                        ),
                        child: ServicesPage(
                          key: _key,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
