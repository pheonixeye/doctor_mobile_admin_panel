import 'package:doctor_mobile_admin_panel/components/generic_dialog_title.dart';
import 'package:doctor_mobile_admin_panel/components/thin_divider.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/base_textfield_validator.dart';
import 'package:doctor_mobile_admin_panel/models/video.dart';
import 'package:doctor_mobile_admin_panel/providers/px_app_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateVideoDialog extends StatefulWidget {
  const CreateVideoDialog({super.key});

  @override
  State<CreateVideoDialog> createState() => _CreateVideoDialogState();
}

class _CreateVideoDialogState extends State<CreateVideoDialog> {
  final formKey = GlobalKey<FormState>(debugLabel: 'video-create-form');

  late final TextEditingController _titleEnController;
  late final TextEditingController _titleArController;
  late final TextEditingController _descEnController;
  late final TextEditingController _descArController;
  late final TextEditingController _srcController;

  bool _isLong = false;

  @override
  void initState() {
    super.initState();
    _titleEnController = TextEditingController();
    _titleArController = TextEditingController();
    _descEnController = TextEditingController();
    _descArController = TextEditingController();
    _srcController = TextEditingController();
  }

  @override
  void dispose() {
    _titleEnController.dispose();
    _titleArController.dispose();
    _descEnController.dispose();
    _descArController.dispose();
    _srcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: GenericDialogTitle(title: context.loc.createVideo),
      insetPadding: EdgeInsets.symmetric(horizontal: 8),
      content: Container(
        width: MediaQuery.sizeOf(context).width - 12,
        decoration: BoxDecoration(),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Card.outlined(
                elevation: 0,
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                child: ListTile(
                  title: Text(context.loc.englishName),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _titleEnController,
                            validator: (value) {
                              return baseValidator(value, context: context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const ThinDivider(),
              Card.outlined(
                elevation: 0,
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                child: ListTile(
                  title: Text(context.loc.arabicName),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _titleArController,
                            validator: (value) {
                              return baseValidator(value, context: context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const ThinDivider(),
              Card.outlined(
                elevation: 0,
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                child: ListTile(
                  title: Text(context.loc.englishDescription),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _descEnController,
                            validator: (value) {
                              return baseValidator(value, context: context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const ThinDivider(),
              Card.outlined(
                elevation: 0,
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                child: ListTile(
                  title: Text(context.loc.arabicDescription),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _descArController,
                            validator: (value) {
                              return baseValidator(value, context: context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const ThinDivider(),
              Card.outlined(
                elevation: 0,
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                child: ListTile(
                  title: Text(context.loc.videoSrc),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _srcController,
                            validator: (value) {
                              return baseValidator(value, context: context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const ThinDivider(),
              Card.outlined(
                elevation: 0,
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(context.loc.isLong),
                  value: _isLong,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _isLong = value;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        IconButton.outlined(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final _video = Video(
                id: '',
                doc_id: context.read<PxAppUsers>().doc_id ?? '',
                title_en: _titleEnController.text,
                title_ar: _titleArController.text,
                description_en: _descEnController.text,
                description_ar: _descArController.text,
                src: _srcController.text,
                thumbnail: '',
                is_long: _isLong,
              );
              Navigator.pop(context, _video);
            }
          },
          tooltip: context.loc.save,
          icon: const Icon(Icons.save),
        ),
        const SizedBox(width: 30),
        IconButton.outlined(
          tooltip: context.loc.cancel,
          onPressed: () {
            Navigator.pop(context, null);
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
