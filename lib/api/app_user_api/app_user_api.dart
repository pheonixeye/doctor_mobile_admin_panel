import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/extensions/annotations.dart';
// import 'package:doctor_mobile_admin_panel/functions/pretty_json.dart';
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
    // dprint(result.user);
    return result.user?.id;
  }

  @override
  Future requestPasswordReset(String email) async {
    await (DataSourceHelper.ds as SupabaseClient)
        .auth
        .resetPasswordForEmail(email);
  }
}
