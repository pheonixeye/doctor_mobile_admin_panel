import 'package:pocketbase/pocketbase.dart';

class PocketbaseHelper {
  static final PocketBase _pb = PocketBase(
      // const String.fromEnvironment("PB_SERVER").isEmpty
      // ?
      "https://probable-stephenie-proklinik-255e04e7.koyeb.app"
      // : const String.fromEnvironment("PB_SERVER"),
      );

  static PocketBase get pb => _pb;
}
