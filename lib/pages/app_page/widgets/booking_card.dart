import 'package:doctor_mobile_admin_panel/extensions/first_where_or_null_ext.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/models/booking.dart';
import 'package:doctor_mobile_admin_panel/providers/px_clinics.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key, required this.booking});
  final Booking booking;
  @override
  Widget build(BuildContext context) {
    final _date = DateTime.parse(booking.date ?? '');
    return Card.outlined(
      elevation: 0,
      color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer2<PxLocale, PxClinics>(
          builder: (context, l, c, _) {
            while (c.clinics == null) {
              return const LinearProgressIndicator();
            }
            final _clinic = c.clinics!
                .firstWhereOrNull((m) => m.clinic.id == booking.clinic_id);
            final _schedule = _clinic?.schedule
                .firstWhereOrNull((s) => s.id == booking.schedule_id);
            while (_clinic == null || _schedule == null) {
              return const LinearProgressIndicator();
            }
            return ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              leading: const CircleAvatar(
                child: Text('@'),
              ),
              title: Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: '${booking.phone}',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Clipboard.setData(
                            ClipboardData(text: booking.phone!),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('copied!'),
                              duration: const Duration(milliseconds: 200),
                            ),
                          );
                        },
                      children: [
                        TextSpan(text: '\n'),
                        TextSpan(
                            text: '${booking.name}',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                            )),
                      ],
                    ),
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              subtitle: Text(DateFormat('dd / MM / yyyy', l.locale.languageCode)
                  .format(_date)),
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    child: Text('@'),
                  ),
                  title: Text(context.loc.clinicInfo),
                  subtitle: Text(
                    l.isEnglish
                        ? _clinic.clinic.name_en
                        : _clinic.clinic.name_ar,
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    child: Text('@'),
                  ),
                  title: Text(context.loc.schedule),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.isEnglish
                            ? _schedule.weekday_en
                            : _schedule.weekday_ar,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        '${context.loc.from} : ${DateFormat.jm(l.locale.languageCode).format(
                          _date.copyWith(
                            hour: _schedule.start_hour,
                            minute: _schedule.start_min,
                          ),
                        )} - ${context.loc.to} : ${DateFormat.jm(l.locale.languageCode).format(
                          _date.copyWith(
                            hour: _schedule.end_hour,
                            minute: _schedule.end_min,
                          ),
                        )}',
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
