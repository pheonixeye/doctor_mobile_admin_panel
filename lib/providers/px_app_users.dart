import 'package:doctor_mobile_admin_panel/api/app_user_api/app_user_api.dart';
import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class PxAppUsers extends ChangeNotifier {
  PxAppUsers({
    required this.userService,
  });

  final HxAppUsers userService;

  static RecordAuth? _model;
  RecordAuth? get model => _model;

  static bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  static String? _doc_id;
  String? get doc_id => _doc_id;

  Future<String?> loginUserByEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await userService.loginUserByEmailAndPassword(
        email,
        password,
      );
      _model = RecordAuth(
        token: result.token,
        record: result.record,
        meta: result.meta,
      );
      _isLoggedIn = true;

      _doc_id = await userService.fetchDoctorProfileId(_model?.record.id ?? '');

      notifyListeners();

      return _model?.record.id;
    } catch (e) {
      rethrow;
    }
  }

  void logout() {
    _isLoggedIn = false;
    _model = null;
    PocketbaseHelper.pb.authStore.clear();
    notifyListeners();
  }

  Future<void> requestPasswordReset(String email) async {
    try {
      await userService.requestPasswordReset(email);
    } catch (e) {
      rethrow;
    }
  }
}
