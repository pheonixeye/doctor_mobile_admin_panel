import 'package:doctor_mobile_admin_panel/components/generic_confirmation_dialog.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/clinic.dart';
import 'package:doctor_mobile_admin_panel/models/clinic_response_model.dart';
import 'package:doctor_mobile_admin_panel/models/schedule.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/clinics_page/widgets/schedule_creation_dialog.dart';
import 'package:doctor_mobile_admin_panel/providers/px_clinics.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClinicViewEditCard extends StatefulWidget {
  const ClinicViewEditCard({super.key, required this.model});
  final ClinicResponseModel model;
  @override
  State<ClinicViewEditCard> createState() => _ClinicViewEditCardState();
}

class _ClinicViewEditCardState extends State<ClinicViewEditCard>
    with SingleTickerProviderStateMixin {
  //TODO: Refactor split into smaller widgets

  late Map<String, TextEditingController> _controllers;
  late Map<String, bool> _isEditing;

  late final TabController _tabController;
  late final ExpansionTileController _tileController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _tileController = ExpansionTileController();
  }

  @override
  void didChangeDependencies() {
    _isEditing = Map.fromEntries(
      Clinic.clinicEditableFields(context).entries.map(
            (entry) => MapEntry<String, bool>(
              entry.key,
              false,
            ),
          ),
    );
    _controllers = Map.fromEntries(
      Clinic.clinicEditableFields(context).entries.map(
            (entry) => MapEntry<String, TextEditingController>(
              entry.key,
              TextEditingController(),
            ),
          ),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controllers.entries.map((e) => e.value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxClinics, PxLocale>(
      builder: (context, c, l, _) {
        return Card.outlined(
          elevation: 0,
          color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
          child: ExpansionTile(
            controller: _tileController,
            tilePadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: const CircleAvatar(
              child: Text('@'),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(l.isEnglish
                  ? widget.model.clinic.name_en
                  : widget.model.clinic.name_ar),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.outlined(
                    tooltip: context.loc.clinicInfo,
                    onPressed: () async {
                      if (_tileController.isExpanded) {
                        setState(() {
                          _tabController.animateTo(0);
                        });
                      }
                    },
                    isSelected: _tabController.index == 0,
                    icon: const Icon(Icons.info),
                  ),
                  const SizedBox(width: 10),
                  IconButton.outlined(
                    tooltip: context.loc.schedule,
                    onPressed: () async {
                      if (_tileController.isExpanded) {
                        setState(() {
                          _tabController.animateTo(1);
                        });
                      }
                    },
                    isSelected: _tabController.index == 1,
                    icon: const Icon(Icons.calendar_month),
                  ),
                  const SizedBox(width: 10),
                  IconButton.outlined(
                    tooltip: context.loc.deleteClinic,
                    onPressed: () async {
                      final _toDelete = await showDialog<bool?>(
                        context: context,
                        builder: (context) {
                          return GenericConfirmationDialog(
                            title: context.loc.deleteClinic,
                            message: context.loc.deleteClinicConfirmation,
                          );
                        },
                      );
                      if (_toDelete == null || _toDelete == false) {
                        return;
                      }
                      if (context.mounted) {
                        await shellFunction(
                          context,
                          toExecute: () async {
                            await c.deleteClinic(widget.model.clinic.id);
                          },
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            children: [
              Container(
                decoration: BoxDecoration(),
                height: MediaQuery.sizeOf(context).height -
                    (MediaQuery.sizeOf(context).height * 0.2),
                width: MediaQuery.sizeOf(context).width,
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card.outlined(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                ListTile(
                                  title: Text(context.loc.clinicInfo),
                                  subtitle: Divider(),
                                ),
                                ...Clinic.clinicEditableFields(context)
                                    .entries
                                    .map((entry) {
                                  return ListTile(
                                    title: Text(entry.value),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          if (_isEditing[entry.key] == true)
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    _controllers[entry.key]
                                                      ?..text = widget
                                                          .model.clinic
                                                          .toJson()[entry.key],
                                              ),
                                            )
                                          else
                                            Expanded(
                                              child: Text(widget.model.clinic
                                                  .toJson()[entry.key]),
                                            ),
                                          const SizedBox(width: 10),
                                          Column(
                                            children: [
                                              IconButton.outlined(
                                                onPressed:
                                                    _isEditing[entry.key] ==
                                                            false
                                                        ? () {
                                                            //change to edit
                                                            setState(() {
                                                              _isEditing[entry
                                                                  .key] = true;
                                                            });
                                                          }
                                                        : () async {
                                                            //save changes && cancel edit
                                                            await shellFunction(
                                                              context,
                                                              toExecute: () {
                                                                c.updateClinicData(
                                                                  widget
                                                                      .model
                                                                      .clinic
                                                                      .id,
                                                                  entry.key,
                                                                  _controllers[entry
                                                                          .key]!
                                                                      .text,
                                                                );

                                                                setState(() {
                                                                  _isEditing[entry
                                                                          .key] =
                                                                      false;
                                                                });
                                                              },
                                                            );
                                                          },
                                                icon: Icon(
                                                    _isEditing[entry.key] ==
                                                            true
                                                        ? Icons.save
                                                        : Icons.edit),
                                              ),
                                              const SizedBox(height: 10),
                                              if (_isEditing[entry.key] == true)
                                                IconButton.outlined(
                                                  onPressed: () {
                                                    setState(() {
                                                      _isEditing[entry.key] =
                                                          false;
                                                    });
                                                  },
                                                  icon: const Icon(Icons.close),
                                                ),
                                              const SizedBox(width: 10),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 10,
                        ),
                        child: Card.outlined(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                ListTile(
                                  title: Text(context.loc.schedule),
                                  subtitle: Divider(),
                                  trailing: IconButton.outlined(
                                    onPressed: () async {
                                      //todo
                                      var _schedule =
                                          await showDialog<Schedule?>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return ScheduleCreationDialog();
                                        },
                                      );
                                      if (_schedule == null) {
                                        return;
                                      }
                                      _schedule = _schedule.copyWith(
                                        clinic_id: widget.model.clinic.id,
                                      );
                                      if (context.mounted) {
                                        await shellFunction(
                                          context,
                                          toExecute: () async {
                                            await c.addClinicSchedule(
                                              _schedule!,
                                            );
                                          },
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ),
                                ...widget.model.schedule.map(
                                  (sch) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        tileColor: Theme.of(context)
                                            .primaryColor
                                            .withValues(alpha: 0.2),
                                        shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        title: Text(
                                          l.isEnglish
                                              ? sch.weekday_en
                                              : sch.weekday_ar,
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: context.loc.from),
                                                    TextSpan(text: ' : '),
                                                    TextSpan(
                                                      text: DateFormat.jm(l
                                                              .locale
                                                              .languageCode)
                                                          .format(
                                                        DateTime.now().copyWith(
                                                          hour: sch.start_hour,
                                                          minute: sch.start_min,
                                                        ),
                                                      ),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () async {
                                                              //todo
                                                              final _updatedTime =
                                                                  await showTimePicker(
                                                                context:
                                                                    context,
                                                                initialTime:
                                                                    TimeOfDay
                                                                        .now(),
                                                              );
                                                              if (_updatedTime ==
                                                                  null) {
                                                                return;
                                                              }
                                                              if (context
                                                                  .mounted) {
                                                                final _newSch =
                                                                    sch.copyWith(
                                                                  start_hour:
                                                                      _updatedTime
                                                                          .hour,
                                                                  start_min:
                                                                      _updatedTime
                                                                          .minute,
                                                                );
                                                                await shellFunction(
                                                                  context,
                                                                  toExecute:
                                                                      () async {
                                                                    await c.updateClinicSchedule(
                                                                        _newSch);
                                                                  },
                                                                );
                                                              }
                                                            },
                                                      style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: const Divider(),
                                                  ),
                                                  SizedBox(width: 10),
                                                  IconButton.outlined(
                                                    onPressed: () async {
                                                      await shellFunction(
                                                        context,
                                                        toExecute: () async {
                                                          await c
                                                              .deleteClinicSchedule(
                                                                  sch.id);
                                                        },
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                ],
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: context.loc.to),
                                                    TextSpan(text: ' : '),
                                                    TextSpan(
                                                      text: DateFormat.jm(l
                                                              .locale
                                                              .languageCode)
                                                          .format(
                                                        DateTime.now().copyWith(
                                                          hour: sch.end_hour,
                                                          minute: sch.end_min,
                                                        ),
                                                      ),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () async {
                                                              //todo
                                                              final _updatedTime =
                                                                  await showTimePicker(
                                                                context:
                                                                    context,
                                                                initialTime:
                                                                    TimeOfDay
                                                                        .now(),
                                                              );
                                                              if (_updatedTime ==
                                                                  null) {
                                                                return;
                                                              }
                                                              if (context
                                                                  .mounted) {
                                                                final _newSch =
                                                                    sch.copyWith(
                                                                  end_hour:
                                                                      _updatedTime
                                                                          .hour,
                                                                  end_min:
                                                                      _updatedTime
                                                                          .minute,
                                                                );
                                                                await shellFunction(
                                                                  context,
                                                                  toExecute:
                                                                      () async {
                                                                    await c.updateClinicSchedule(
                                                                        _newSch);
                                                                  },
                                                                );
                                                              }
                                                            },
                                                      style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        trailing: Switch.adaptive(
                                          value: sch.available,
                                          onChanged: (value) async {
                                            final _sch = sch.copyWith(
                                              available: value,
                                            );
                                            await shellFunction(
                                              context,
                                              toExecute: () async {
                                                await c
                                                    .updateClinicSchedule(_sch);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
