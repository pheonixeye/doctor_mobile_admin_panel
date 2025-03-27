import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctor_mobile_admin_panel/components/central_loading.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/extensions/weekdays.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/logic/date_provider.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/widgets/booking_card.dart';
import 'package:doctor_mobile_admin_panel/providers/px_bookings.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with AfterLayoutMixin {
  final _dateProvider = WidgetsDateProvider();
  static const double _textWidth = 50;
  static const double _daysWidth = 100;
  static const double _monthsWidth = 150;
  static const double _yearsWidth = 120;
  late final ScrollController _yearsController = ScrollController();
  late final ScrollController _monthsController = ScrollController();
  late final ScrollController _daysController = ScrollController();

  void _animateToIndex(
    ScrollController _controller,
    int index,
    double _width,
  ) {
    if (_controller.hasClients) {
      _controller.animateTo(
        (index - 1) * _width,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
      return;
    }
    Future.delayed(const Duration(milliseconds: 200))
        .then((val) => _animateToIndex(_controller, index, _width));
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    _animateToIndex(_monthsController, DateTime.now().month, _monthsWidth);
    _animateToIndex(_daysController, DateTime.now().day, _daysWidth);
  }

  @override
  void dispose() {
    _yearsController.dispose();
    _monthsController.dispose();
    _daysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<PxBookings, PxLocale>(
        builder: (context, b, l, _) {
          while (b.bookings == null) {
            return const CentralLoading();
          }
          return ListView(
            cacheExtent: 3000,
            restorationId: 'bookings-page-items',
            children: [
              ListTile(
                leading: FloatingActionButton.small(
                  heroTag: 'all-month-bookings',
                  tooltip: "All Month's Bookings",
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () {
                    shellFunction(
                      context,
                      toExecute: () {
                        b.filterThisMonthBooking();
                      },
                    );
                  },
                  child: const Icon(Icons.calendar_month),
                ),
                title: Row(
                  children: [
                    Text(context.loc.bookings),
                    const Spacer(),
                    Text(DateFormat('dd / MM / yyyy', l.locale.languageCode)
                        .format(b.date)),
                    const SizedBox(width: 10),
                  ],
                ),
                subtitle: const Divider(),
                trailing: FloatingActionButton.small(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  tooltip: "Today's Bookings",
                  heroTag: 'today-bookings',
                  onPressed: () {
                    final _today = DateTime.now();
                    shellFunction(
                      context,
                      toExecute: () {
                        b.setDate(
                          y: _today.year,
                          m: _today.month,
                          d: _today.day,
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.today),
                ),
              ),

              //extract this into another widget
              //use provider for date instead of setstate
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: _textWidth,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          SizedBox(
                            width: _textWidth,
                            child: Text(context.loc.year),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ListView(
                              controller: _yearsController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                ..._dateProvider.years.map((e) {
                                  bool isSelected = e == b.date.year;
                                  return SizedBox(
                                    width: _yearsWidth,
                                    child: Card(
                                      elevation: isSelected ? 0 : 10,
                                      child: RadioMenuButton<int>(
                                        value: e,
                                        groupValue: b.date.year,
                                        onChanged: (value) {
                                          shellFunction(
                                            context,
                                            toExecute: () {
                                              b.setDate(y: value);
                                            },
                                          );
                                        },
                                        child: Text(e.toString()),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _textWidth,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          SizedBox(
                            width: _textWidth,
                            child: Text(context.loc.month),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ListView(
                              controller: _monthsController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                ..._dateProvider.months.entries.map((e) {
                                  bool isSelected = e.key == b.date.month;
                                  return SizedBox(
                                    width: _monthsWidth,
                                    child: Card(
                                      elevation: isSelected ? 0 : 10,
                                      child: RadioMenuButton<int>(
                                        value: e.key,
                                        groupValue: b.date.month,
                                        onChanged: (value) {
                                          shellFunction(
                                            context,
                                            toExecute: () {
                                              b.setDate(m: value);
                                            },
                                          );
                                        },
                                        child: Text(e.value),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _textWidth,
                      child: Row(
                        children: [
                          // const Gap(10),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: _textWidth,
                            child: Text(context.loc.day),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ListView(
                              controller: _daysController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                ..._dateProvider
                                    .daysPerMonth(b.date.month)
                                    .map((e) {
                                  bool isSelected = e == b.date.day;

                                  return SizedBox(
                                    width: _daysWidth,
                                    child: Card(
                                      elevation: isSelected ? 0 : 10,
                                      child: RadioMenuButton<int>(
                                        style: const ButtonStyle(
                                          padding: WidgetStatePropertyAll(
                                            EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                          ),
                                        ),
                                        value: e,
                                        groupValue: b.date.day,
                                        onChanged: (value) {
                                          shellFunction(context, toExecute: () {
                                            b.setDate(d: value);
                                          });
                                        },
                                        child: Text(
                                            '$e ${DateTime(b.date.year, b.date.month, e).weekday.toWeekdayInitials()}'),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              if (b.bookings == null)
                Center(
                  child: CircularProgressIndicator(),
                )
              else if (b.filteredBookings!.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: Text(context.loc.noBookingsForDate),
                  ),
                )
              else
                ...b.filteredBookings!.map((booking) {
                  return BookingCard(booking: booking);
                })
            ],
          );
        },
      ),
    );
  }
}
