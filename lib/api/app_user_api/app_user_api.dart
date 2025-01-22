import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:pocketbase/pocketbase.dart';

class HxAppUsers {
  const HxAppUsers();

  Future<RecordAuth> loginUserByEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await PocketbaseHelper.pb
          .collection("users")
          .authWithPassword(email, password);
      return result;
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }

  Future<void> requestPasswordReset(String email) async {
    try {
      await PocketbaseHelper.pb.collection("users").requestPasswordReset(email);
    } on ClientException catch (e) {
      throw Exception(e.response["message"]);
    }
  }
}
