import 'package:doctor_mobile_admin_panel/extensions/doctor_url_extractor.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
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
    return Consumer<PxProfile>(
      builder: (context, p, _) {
        return Scaffold(
          body: ListView(
            cacheExtent: 3000,
            children: [
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
                                  allowedExtensions: ['webp', 'png', 'jpg'],
                                );

                                if (bytes == null) {
                                  return;
                                }

                                if (context.mounted) {
                                  await shellFunction(
                                    context,
                                    toExecute: () async {
                                      await p.editDoctorAvatarAndLogo(
                                        field.key,
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
                              p.doctor?.imageUrl(
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
            ],
          ),
        );
      },
    );
  }
}
