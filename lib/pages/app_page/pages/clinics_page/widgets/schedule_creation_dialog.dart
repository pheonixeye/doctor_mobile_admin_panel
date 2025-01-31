import 'package:doctor_mobile_admin_panel/components/generic_dialog_title.dart';
import 'package:doctor_mobile_admin_panel/components/time_picker.dart' as tp;
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/models/schedule.dart';
import 'package:doctor_mobile_admin_panel/models/weekdays_model.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleCreationDialog extends StatefulWidget {
  const ScheduleCreationDialog({super.key});

  @override
  State<ScheduleCreationDialog> createState() => _ScheduleCreationDialogState();
}

class _ScheduleCreationDialogState extends State<ScheduleCreationDialog>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  Schedule _state = Schedule.empty();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late final Map<int, String> _tabPagesTitles = {
    0: context.loc.selectWeekday,
    1: context.loc.selectStartTime,
    2: context.loc.selectEndTime,
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: GenericDialogTitle(title: context.loc.schedule),
      insetPadding: const EdgeInsets.all(2),
      contentPadding: const EdgeInsets.all(8),
      content: Consumer<PxLocale>(
        builder: (context, l, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width - 10,
            height: _tabController.index != 0
                ? MediaQuery.sizeOf(context).height / 1.5
                : MediaQuery.sizeOf(context).height / 2,
            decoration: BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: IconButton.outlined(
                      onPressed: () {
                        setState(() {
                          if (_tabController.index == 0) {
                            Navigator.pop(context, null);
                          } else {
                            _tabController.animateTo(_tabController.index - 1);
                          }
                        });
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    title: Text(_tabPagesTitles[_tabController.index] ?? ''),
                    subtitle: const Divider(),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card.outlined(
                              elevation: 8,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  ...Weekday.WEEKDAYS.map((weekday) {
                                    return FilterChip(
                                      label: Text(
                                        l.isEnglish
                                            ? weekday.weekdayEn
                                            : weekday.weekdayAr,
                                      ),
                                      selected: _state.intday == weekday.intDay,
                                      onSelected: (value) {
                                        setState(() {
                                          _state = _state.copyWith(
                                            weekday_en: weekday.weekdayEn,
                                            weekday_ar: weekday.weekdayAr,
                                            intday: weekday.intDay,
                                          );
                                          _tabController.animateTo(1);
                                        });
                                      },
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: tp.TimePicker(
                                    entryMode: tp.TimePickerEntryMode.dial,
                                    time: TimeOfDay(
                                      hour: _state.start_hour,
                                      minute: _state.start_min,
                                    ),
                                    onTimeChanged: (value) {
                                      setState(() {
                                        _state = _state.copyWith(
                                          start_hour: value.hour,
                                          start_min: value.minute,
                                        );
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        _tabController.animateTo(2);
                                      });
                                    },
                                    label: Text(context.loc.next),
                                    icon: const Icon(Icons.arrow_forward),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: tp.TimePicker(
                                    entryMode: tp.TimePickerEntryMode.dialOnly,
                                    time: TimeOfDay(
                                      hour: _state.end_hour,
                                      minute: _state.end_min,
                                    ),
                                    onTimeChanged: (value) {
                                      setState(() {
                                        _state = _state.copyWith(
                                          end_hour: value.hour,
                                          end_min: value.minute,
                                        );
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context, _state);
                                    },
                                    label: Text(context.loc.save),
                                    icon: const Icon(Icons.save),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
