import 'package:doctor_mobile_admin_panel/components/central_loading.dart';
import 'package:doctor_mobile_admin_panel/extensions/for_widgets_on_site_settings.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/site_settings.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/site_settings_page/widgets/site_settings/widgets/color_picker_dialog.dart';
import 'package:doctor_mobile_admin_panel/providers/px_site_settings.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SiteSettingsView extends StatefulWidget {
  const SiteSettingsView({super.key});

  @override
  State<SiteSettingsView> createState() => _SiteSettingsViewState();
}

class _SiteSettingsViewState extends State<SiteSettingsView> {
  late Map<String, TextEditingController> _controllers;
  late Map<String, bool> _isEditing;
  @override
  void didChangeDependencies() {
    _isEditing = Map.fromEntries(
      SiteSettings.forWidgetsJson().map(
        (entry) => MapEntry<String, bool>(
          entry,
          false,
        ),
      ),
    );
    _controllers = Map.fromEntries(
      SiteSettings.forWidgetsJson().map(
        (entry) => MapEntry<String, TextEditingController>(
          entry,
          TextEditingController(),
        ),
      ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PxSiteSettings>(
      builder: (context, s, _) {
        return ListView(
          cacheExtent: 3000,
          children: [
            ListTile(
              leading: const CircleAvatar(),
              title: Text(context.loc.siteSettings),
              subtitle: const Divider(),
            ),
            if (s.settings == null)
              Padding(
                padding: const EdgeInsets.only(top: 280.0),
                child: const CentralLoading(),
              )
            else
              ...s.settings!.websiteTitleSettings(context).entries.map((entry) {
                return Card.outlined(
                  elevation: 0,
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          entry.value,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: entry.key.contains('color')
                            ? InkWell(
                                onTap: () async {
                                  final _color = await showDialog<Color?>(
                                    context: context,
                                    builder: (context) {
                                      return ColorPickerDialog();
                                    },
                                  );
                                  if (_color == null) {
                                    return;
                                  }
                                  if (context.mounted) {
                                    await shellFunction(
                                      context,
                                      toExecute: () async {
                                        await s.updateSiteSettings(
                                          s.settings!.id,
                                          {entry.key: _color.hexCode},
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(
                                        '0xff${s.settings?.toJson()[entry.key] ?? 'ffffff'}')),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(),
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  if (_isEditing[entry.key] == false)
                                    Text(
                                        '${s.settings?.toJson()[entry.key] ?? '0'} px')
                                  else ...[
                                    Expanded(
                                      child: TextFormField(
                                        controller: _controllers[entry.key]
                                          ?..text =
                                              '${s.settings?.toJson()[entry.key]}',
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    IconButton.outlined(
                                      onPressed: () async {
                                        await shellFunction(
                                          context,
                                          toExecute: () async {
                                            await s.updateSiteSettings(
                                              s.settings!.id,
                                              {
                                                entry.key:
                                                    _controllers[entry.key]
                                                        ?.text,
                                              },
                                            );
                                          },
                                        );
                                        setState(() {
                                          _isEditing[entry.key] = false;
                                        });
                                      },
                                      icon: const Icon(Icons.save),
                                    ),
                                  ]
                                ],
                              ),
                      ),
                      trailing: entry.key.contains('color')
                          ? null
                          : IconButton.outlined(
                              onPressed: () {
                                setState(() {
                                  if (_isEditing[entry.key] == false) {
                                    _isEditing[entry.key] = true;
                                  } else {
                                    _isEditing[entry.key] = false;
                                  }
                                });
                              },
                              icon: Icon(
                                _isEditing[entry.key] == false
                                    ? Icons.edit
                                    : Icons.close,
                              ),
                            ),
                    ),
                  ),
                );
              })
          ],
        );
      },
    );
  }
}
