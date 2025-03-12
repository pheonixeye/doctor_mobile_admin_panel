import 'package:doctor_mobile_admin_panel/components/central_loading.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/widgets/booking_card.dart';
import 'package:doctor_mobile_admin_panel/providers/px_bookings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PxBookings>(
        builder: (context, b, _) {
          while (b.bookings == null) {
            return const CentralLoading();
          }
          return ListView(
            cacheExtent: 3000,
            restorationId: 'videos-page-items',
            children: [
              ListTile(
                leading: const CircleAvatar(),
                title: Text(context.loc.bookings),
                subtitle: const Divider(),
                //TODO: Add filter widget
              ),
              if (b.bookings == null)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                ...b.bookings!.map((booking) {
                  return BookingCard(booking: booking);
                })
            ],
          );
        },
      ),
    );
  }
}
