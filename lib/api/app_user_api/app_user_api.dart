import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
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

  //nessecary transition request as all db fields are linked to doc_id - not user_id
  Future<String?> fetchDoctorProfileId(String user_id) async {
    final result = await PocketbaseHelper.pb
        .collection(HxProfile.collection)
        .getFirstListItem('user_id = "$user_id"');
    return result.id;
  }
}
