import 'package:doctor_mobile_admin_panel/constants/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum DataSource {
  pb,
  sb;

  const DataSource();
}

class DataSourceHelper {
  //TODO: change dynamically
  final DataSource _dataSource = DataSource.sb;

  DataSource get dataSource => _dataSource;

  static dynamic _ds;

  static dynamic get ds => _ds;

  DataSourceHelper() {
    _ds ??= switch (_dataSource) {
      DataSource.pb => PocketBase(dotenv.env[AppConstants.POCKETBASE_URL]!),
      DataSource.sb => Supabase.instance.client,
    };
  }
}

typedef Pocket = PocketBase;
typedef Supa = SupabaseClient;

class PocketbaseHelper {
  static final PocketBase _pb =
      PocketBase(dotenv.env[AppConstants.POCKETBASE_URL]!);

  static PocketBase get pb => _pb;
}
