import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/site_settings_page/widgets/site_settings/widgets/color_picker_dialog.dart';
import 'package:doctor_mobile_admin_panel/providers/px_site_settings.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SiteSettingsItem extends StatefulWidget {
  const SiteSettingsItem({
    super.key,
    required this.isEditing,
    required this.entry,
    required this.controller,
  });
  final bool isEditing;
  final MapEntry<String, String> entry;
  final TextEditingController controller;

  @override
  State<SiteSettingsItem> createState() => _SiteSettingsItemState();
}

class _SiteSettingsItemState extends State<SiteSettingsItem> {
  late bool _isEditing;
  late TextEditingController _controller;

  @override
  void didChangeDependencies() {
    _isEditing = widget.isEditing;
    _controller = widget.controller;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PxSiteSettings>(
      builder: (context, s, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card.outlined(
            elevation: 0,
            color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.entry.value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.entry.key.contains('color')
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
                                    {widget.entry.key: _color.hexCode},
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
                                  '0x00${s.settings?.toJson()[widget.entry.key] ?? 'ffffff'}')),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(),
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            if (_isEditing == false)
                              Text(
                                  '${s.settings?.toJson()[widget.entry.key] ?? '0'} px')
                            else ...[
                              Expanded(
                                child: TextFormField(
                                  controller: _controller
                                    ..text =
                                        '${s.settings?.toJson()[widget.entry.key]}',
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
                                          widget.entry.key: _controller.text,
                                        },
                                      );
                                    },
                                  );
                                  setState(() {
                                    _isEditing = false;
                                  });
                                },
                                icon: const Icon(Icons.save),
                              ),
                            ]
                          ],
                        ),
                ),
                trailing: widget.entry.key.contains('color')
                    ? null
                    : IconButton.outlined(
                        onPressed: () {
                          setState(() {
                            if (_isEditing == false) {
                              _isEditing = true;
                            } else {
                              _isEditing = false;
                            }
                          });
                        },
                        icon: Icon(
                          _isEditing == false ? Icons.edit : Icons.close,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
