import 'package:doctor_mobile_admin_panel/components/generic_dialog_title.dart';
import 'package:doctor_mobile_admin_panel/components/thin_divider.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/base_textfield_validator.dart';
import 'package:doctor_mobile_admin_panel/models/doctor_about.dart';
import 'package:doctor_mobile_admin_panel/providers/px_app_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateDoctorAboutDialog extends StatefulWidget {
  const CreateDoctorAboutDialog({super.key});

  @override
  State<CreateDoctorAboutDialog> createState() =>
      _CreateDoctorAboutDialogState();
}

class _CreateDoctorAboutDialogState extends State<CreateDoctorAboutDialog> {
  final formKey = GlobalKey<FormState>(debugLabel: 'doctor_about-create-form');

  late final TextEditingController _aboutEnController;
  late final TextEditingController _aboutArController;

  @override
  void initState() {
    super.initState();
    _aboutEnController = TextEditingController();
    _aboutArController = TextEditingController();
  }

  @override
  void dispose() {
    _aboutEnController.dispose();
    _aboutArController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: GenericDialogTitle(title: context.loc.addDoctorAbout),
      insetPadding: EdgeInsets.symmetric(horizontal: 8),
      content: Container(
        width: MediaQuery.sizeOf(context).width - 12,
        decoration: BoxDecoration(),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card.outlined(
                elevation: 0,
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                child: ListTile(
                  title: Text(context.loc.englishTitle),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _aboutEnController,
                            maxLines: 2,
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
                  title: Text(context.loc.arabicTitle),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _aboutArController,
                            maxLines: 2,
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
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        IconButton.outlined(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final _about = DoctorAbout(
                id: '',
                doc_id: context.read<PxAppUsers>().doc_id ?? '',
                about_en: _aboutEnController.text,
                about_ar: _aboutArController.text,
              );
              Navigator.pop(context, _about);
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
