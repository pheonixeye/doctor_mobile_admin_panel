import 'package:doctor_mobile_admin_panel/components/generic_dialog_title.dart';
import 'package:doctor_mobile_admin_panel/components/thin_divider.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/base_textfield_validator.dart';
import 'package:doctor_mobile_admin_panel/models/service.dart';
import 'package:doctor_mobile_admin_panel/providers/px_app_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateServiceDialog extends StatefulWidget {
  const CreateServiceDialog({super.key});

  @override
  State<CreateServiceDialog> createState() => _CreateServiceDialogState();
}

class _CreateServiceDialogState extends State<CreateServiceDialog> {
  final formKey = GlobalKey<FormState>(debugLabel: 'service-create-form');

  late final TextEditingController _nameEnController;
  late final TextEditingController _nameArController;
  late final TextEditingController _descEnController;
  late final TextEditingController _descArController;

  @override
  void initState() {
    super.initState();
    _nameEnController = TextEditingController();
    _nameArController = TextEditingController();
    _descEnController = TextEditingController();
    _descArController = TextEditingController();
  }

  @override
  void dispose() {
    _nameEnController.dispose();
    _nameArController.dispose();
    _descEnController.dispose();
    _descArController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: GenericDialogTitle(title: context.loc.createService),
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
                  title: Text(context.loc.englishName),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _nameEnController,
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
                            controller: _nameArController,
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
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        IconButton.outlined(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final _service = Service(
                id: '',
                doc_id: context.read<PxAppUsers>().doc_id ?? '',
                name_en: _nameEnController.text,
                name_ar: _nameArController.text,
                description_en: _descEnController.text,
                description_ar: _descArController.text,
                faq_ids: [],
                image: '',
              );
              Navigator.pop(context, _service);
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
