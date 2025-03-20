import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/extensions/annotations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppUsersApi {
  AppUsersApi();
  static final DataSourceHelper _helper = DataSourceHelper();

  Future<String?> loginUserByEmailAndPassword(String email, String password);

  Future<void> requestPasswordReset(String email);

  // Future fetchDoctorProfileId(String user_id);

  factory AppUsersApi.common() {
    return switch (_helper.dataSource) {
      DataSource.pb => HxAppUsersPocketbase(),
      DataSource.sb => HxAppUsersSupabase(),
    };
  }
}

@POCKETBASE()
class HxAppUsersPocketbase implements AppUsersApi {
  HxAppUsersPocketbase();

  @override
  Future<String?> loginUserByEmailAndPassword(
      String email, String password) async {
    try {
      final result = await (DataSourceHelper.ds as PocketBase)
          .collection("users")
          .authWithPassword(email, password);
      return result.record.id;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    try {
      await (DataSourceHelper.ds as PocketBase)
          .collection("users")
          .requestPasswordReset(email);
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }
}

@SUPABASE()
class HxAppUsersSupabase implements AppUsersApi {
  HxAppUsersSupabase();

  @override
  Future<String?> loginUserByEmailAndPassword(
    String email,
    String password,
  ) async {
    final result = await (DataSourceHelper.ds as SupabaseClient)
        .auth
        .signInWithPassword(email: email, password: password);
    if (result.user != null && result.user!.id.isNotEmpty) {
      //todo: add firebase fetching token logic

      await FirebaseMessaging.instance.requestPermission();
      final fcm_token = await FirebaseMessaging.instance.getToken();
      if (fcm_token != null) {
        await (DataSourceHelper.ds as SupabaseClient)
            .from('doctors')
            .update({'fcm_token': fcm_token}).eq('id', result.user!.id);
      }
      return result.user?.id;
    }
    return null;
  }

  @override
  Future requestPasswordReset(String email) async {
    await (DataSourceHelper.ds as SupabaseClient)
        .auth
        .resetPasswordForEmail(email);
  }
}
