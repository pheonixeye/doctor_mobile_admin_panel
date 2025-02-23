import 'package:doctor_mobile_admin_panel/components/generic_confirmation_dialog.dart';
import 'package:doctor_mobile_admin_panel/constants/constants.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/extensions/model_image_url_extractor.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:doctor_mobile_admin_panel/models/doctor_about.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/profile_page/widgets/create_doctor_about_dialog.dart';
import 'package:doctor_mobile_admin_panel/providers/px_doctor_about.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:doctor_mobile_admin_panel/providers/px_profile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map<String, TextEditingController> _controllers;
  late Map<String, bool> _isEditing;

  @override
  void didChangeDependencies() {
    _isEditing = Map.fromEntries(
      Doctor.doctorEditableFields(context).entries.map(
            (entry) => MapEntry<String, bool>(
              entry.key,
              false,
            ),
          ),
    );
    _controllers = Map.fromEntries(
      Doctor.doctorEditableFields(context).entries.map(
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
    return Consumer3<PxLocale, PxProfile, PxDoctorAbout>(
      builder: (context, l, p, d, _) {
        return Scaffold(
          body: ListView(
            cacheExtent: 3000,
            children: [
              ListTile(
                leading: const CircleAvatar(),
                title: Text(context.loc.profile),
                subtitle: const Divider(),
              ),
              ...Doctor.doctorEditableFields(context).entries.map((field) {
                if (field.key == 'avatar' || field.key == 'logo') {
                  return Card.outlined(
                    elevation: 0,
                    color:
                        Theme.of(context).primaryColor.withValues(alpha: 0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(field.value),
                            ),
                            const SizedBox(width: 10),
                            IconButton.outlined(
                              onPressed: () async {
                                final bytes =
                                    await FilePicker.platform.pickFiles(
                                  withData: true,
                                  type: FileType.custom,
                                  allowedExtensions:
                                      AppConstants.imageAllowedExtentions,
                                );

                                if (bytes == null) {
                                  return;
                                }

                                if (context.mounted) {
                                  await shellFunction(
                                    context,
                                    toExecute: () async {
                                      await p.editDoctorAvatarAndLogo(
                                        '${field.key}.${bytes.xFiles.first.name.split('.').last}',
                                        await bytes.xFiles.first.readAsBytes(),
                                      );
                                    },
                                  );
                                }
                              },
                              icon: const Icon(Icons.image),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(),
                            child: Image.network(
                              p.doctor?.imageUrlByKey(
                                      p.doctor?.toJson()[field.key]) ??
                                  '',
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Card.outlined(
                  elevation: 0,
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(field.value),
                      subtitle: Row(
                        children: (_controllers[field.key] != null &&
                                _isEditing[field.key] != null)
                            ? [
                                if (_isEditing[field.key]!)
                                  Expanded(
                                    child: TextFormField(
                                      controller: _controllers[field.key]
                                        ?..text = p.doctor?.toJson()[field.key],
                                    ),
                                  )
                                else if (p.doctor == null)
                                  Expanded(
                                    child: const LinearProgressIndicator(),
                                  )
                                else
                                  Expanded(
                                    child: Text(p.doctor!.toJson()[field.key] ??
                                        '*****'),
                                  ),
                                const SizedBox(width: 10),
                                IconButton.outlined(
                                  onPressed: _isEditing[field.key] == false
                                      ? () {
                                          //change to edit
                                          setState(() {
                                            _isEditing[field.key] = true;
                                          });
                                        }
                                      : () async {
                                          //save changes && cancel edit
                                          await shellFunction(
                                            context,
                                            toExecute: () {
                                              p.editDoctorProfileByKey(
                                                field.key,
                                                _controllers[field.key]!.text,
                                              );

                                              setState(() {
                                                _isEditing[field.key] = false;
                                              });
                                            },
                                          );
                                        },
                                  icon: Icon(_isEditing[field.key] == true
                                      ? Icons.save
                                      : Icons.edit),
                                ),
                                const SizedBox(width: 10),
                                if (_isEditing[field.key] == true)
                                  IconButton.outlined(
                                    onPressed: () {
                                      setState(() {
                                        _isEditing[field.key] = false;
                                      });
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                const SizedBox(width: 10),
                              ]
                            : [],
                      ),
                    ),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Divider(),
              ),
              ListTile(
                leading: const CircleAvatar(),
                title: Text(context.loc.doctorAbout),
                subtitle: const Divider(),
                trailing: IconButton.outlined(
                  onPressed: () async {
                    final _about = await showDialog<DoctorAbout?>(
                      context: context,
                      builder: (context) {
                        return CreateDoctorAboutDialog();
                      },
                    );
                    if (_about == null) {
                      return;
                    }
                    if (context.mounted) {
                      await shellFunction(
                        context,
                        toExecute: () async {
                          await d.addNewAbout(_about);
                        },
                      );
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
              if (d.abouts == null)
                Center(
                  child: CircularProgressIndicator(),
                )
              else if (d.abouts != null && d.abouts!.isEmpty)
                const SizedBox()
              else
                ...d.abouts!.map((about) {
                  return Card.outlined(
                    elevation: 0,
                    color:
                        Theme.of(context).primaryColor.withValues(alpha: 0.2),
                    child: ListTile(
                      title: Text(about.about_en),
                      subtitle: Text(about.about_ar),
                      trailing: IconButton.outlined(
                        onPressed: () async {
                          final _toDelete = await showDialog<bool?>(
                            context: context,
                            builder: (context) {
                              return GenericConfirmationDialog(
                                title: context.loc.deleteAbout,
                                message: context.loc.confirmDeleteAbout,
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
                                await d.deleteAbout(about.id);
                              },
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                })
            ],
          ),
        );
      },
    );
  }
}
