// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pocketbase/pocketbase.dart';

import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/extensions/annotations.dart';
import 'package:doctor_mobile_admin_panel/models/booking.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BookingsApi {
  BookingsApi();

  static final _helper = DataSourceHelper();

  Future<List<Booking>> getDoctorBookings();

  factory BookingsApi.common(String doc_id) {
    return switch (_helper.dataSource) {
      DataSource.pb => PxBookingsPocketbase(doc_id: doc_id),
      DataSource.sb => PxBookingsSupabase(doc_id: doc_id),
    };
  }
}

@POCKETBASE()
class PxBookingsPocketbase extends BookingsApi {
  PxBookingsPocketbase({required this.doc_id});
  final String doc_id;

  static const String collection = 'bookings';

  final _client = DataSourceHelper.ds as PocketBase;

  @override
  Future<List<Booking>> getDoctorBookings() async {
    final _result = await _client
        .collection(collection)
        .getList(filter: 'doc_id = "$doc_id"');

    return _result.items.map((e) => Booking.fromJson(e.toJson())).toList();
  }
}

@SUPABASE()
class PxBookingsSupabase extends BookingsApi {
  PxBookingsSupabase({required this.doc_id});
  final String doc_id;

  static const String collection = 'bookings';

  final _client = DataSourceHelper.ds as SupabaseClient;

  @override
  Future<List<Booking>> getDoctorBookings() async {
    final _result =
        await _client.from(collection).select().eq('doc_id', doc_id);

    return _result.map((e) => Booking.fromJson(e)).toList();
  }
}
