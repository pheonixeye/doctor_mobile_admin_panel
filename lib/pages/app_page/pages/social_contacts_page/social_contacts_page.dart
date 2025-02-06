import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/social_contact.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:doctor_mobile_admin_panel/providers/px_social_contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialContactsPage extends StatefulWidget {
  const SocialContactsPage({super.key});

  @override
  State<SocialContactsPage> createState() => _SocialContactsPageState();
}

class _SocialContactsPageState extends State<SocialContactsPage> {
  late Map<String, TextEditingController> _controllers;
  late Map<String, bool> _isEditing;

  @override
  void didChangeDependencies() {
    _isEditing = Map.fromEntries(
      SocialContact.editableFields(context).entries.map(
            (entry) => MapEntry<String, bool>(
              entry.key,
              false,
            ),
          ),
    );
    _controllers = Map.fromEntries(
      SocialContact.editableFields(context).entries.map(
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
    _controllers.entries.map((e) => e.value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<PxSocialContact, PxLocale>(
        builder: (context, s, l, _) {
          return ListView(
            restorationId: 'social_contacts_list_page',
            children: [
              ListTile(
                leading: const CircleAvatar(),
                title: Text(context.loc.socialContacts),
                subtitle: const Divider(),
              ),
              if (s.socialContact == null)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                ...SocialContact.editableFields(context).entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card.outlined(
                      color:
                          Theme.of(context).primaryColor.withValues(alpha: 0.2),
                      elevation: 0,
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(entry.value),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              if (_isEditing[entry.key] == true)
                                Expanded(
                                  child: TextFormField(
                                    controller: _controllers[entry.key]
                                      ?..text =
                                          s.socialContact?.toJson()[entry.key],
                                  ),
                                )
                              else
                                Expanded(
                                  child: Text(
                                      s.socialContact?.toJson()[entry.key]),
                                ),
                              const SizedBox(width: 10),
                              Column(
                                children: [
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
                                              toExecute: () async {
                                                //todo

                                                final _update = {
                                                  entry.key:
                                                      _controllers[entry.key]
                                                          ?.text
                                                };
                                                await s.updateSocialContactData(
                                                  _update,
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
                                  const SizedBox(height: 10),
                                  if (_isEditing[entry.key] == true)
                                    IconButton.outlined(
                                      onPressed: () {
                                        setState(() {
                                          _isEditing[entry.key] = false;
                                        });
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            ],
          );
        },
      ),
    );
  }
}
