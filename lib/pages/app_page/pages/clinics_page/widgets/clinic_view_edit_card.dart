import 'package:doctor_mobile_admin_panel/components/generic_confirmation_dialog.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/clinic.dart';
import 'package:doctor_mobile_admin_panel/providers/px_clinics.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicViewEditCard extends StatefulWidget {
  const ClinicViewEditCard({super.key, required this.clinic});
  final Clinic clinic;
  @override
  State<ClinicViewEditCard> createState() => _ClinicViewEditCardState();
}

class _ClinicViewEditCardState extends State<ClinicViewEditCard> {
  late Map<String, TextEditingController> _controllers;
  late Map<String, bool> _isEditing;

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
  Widget build(BuildContext context) {
    return Consumer2<PxClinics, PxLocale>(
      builder: (context, c, l, _) {
        return Card.outlined(
          elevation: 0,
          color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: const CircleAvatar(
              child: Text('*'),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  l.isEnglish ? widget.clinic.name_en : widget.clinic.name_ar),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.outlined(
                    tooltip: context.loc.schedule,
                    onPressed: () async {
                      //TODO:
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
                  const SizedBox(width: 10),
                  IconButton.outlined(
                    tooltip: context.loc.offDates,
                    onPressed: () async {
                      //TODO:
                    },
                    icon: const Icon(Icons.airplanemode_inactive),
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
                            await c.deleteClinic(widget.clinic.id);
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
              ...Clinic.clinicEditableFields(context).entries.map((entry) {
                return ListTile(
                  leading: const CircleAvatar(radius: 10),
                  title: Text(entry.value),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        if (_isEditing[entry.key] == true)
                          Expanded(
                            child: TextFormField(
                              controller: _controllers[entry.key]
                                ?..text = widget.clinic.toJson()[entry.key],
                            ),
                          )
                        else
                          Expanded(
                            child: Text(widget.clinic.toJson()[entry.key]),
                          ),
                        const SizedBox(width: 10),
                        IconButton.outlined(
                          onPressed: _isEditing[entry.key] == false
                              ? () {
                                  //change to edit
                                  setState(() {
                                    _isEditing[entry.key] = true;
                                  });
                                }
                              : () async {
                                  //save changes && cancel edit
                                  await shellFunction(
                                    context,
                                    toExecute: () {
                                      c.updateClinicData(
                                        widget.clinic.id,
                                        entry.key,
                                        _controllers[entry.key]!.text,
                                      );

                                      setState(() {
                                        _isEditing[entry.key] = false;
                                      });
                                    },
                                  );
                                },
                          icon: Icon(_isEditing[entry.key] == true
                              ? Icons.save
                              : Icons.edit),
                        ),
                        const SizedBox(width: 10),
                        if (_isEditing[entry.key] == true)
                          IconButton.outlined(
                            onPressed: () {
                              setState(() {
                                _isEditing[entry.key] = false;
                              });
                            },
                            icon: const Icon(Icons.close),
                          ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
