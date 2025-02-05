import 'package:doctor_mobile_admin_panel/components/generic_dialog_title.dart';
import 'package:doctor_mobile_admin_panel/components/thin_divider.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/base_textfield_validator.dart';
import 'package:doctor_mobile_admin_panel/models/faq.dart';
import 'package:doctor_mobile_admin_panel/models/service_response_model.dart';
import 'package:flutter/material.dart';

class CreateFaqDialog extends StatefulWidget {
  const CreateFaqDialog({super.key, required this.model});
  final ServiceResponseModel model;

  @override
  State<CreateFaqDialog> createState() => _CreateFaqDialogState();
}

class _CreateFaqDialogState extends State<CreateFaqDialog> {
  final formKey = GlobalKey<FormState>(debugLabel: 'faq-create-form');

  late final TextEditingController _qEnController;
  late final TextEditingController _qArController;
  late final TextEditingController _aEnController;
  late final TextEditingController _aArController;

  @override
  void initState() {
    super.initState();
    _qEnController = TextEditingController();
    _qArController = TextEditingController();
    _aEnController = TextEditingController();
    _aArController = TextEditingController();
  }

  @override
  void dispose() {
    _qEnController.dispose();
    _qArController.dispose();
    _aEnController.dispose();
    _aArController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: GenericDialogTitle(title: context.loc.addServiceFaq),
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
                  title: Text(context.loc.englishQuestion),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _qEnController,
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
                  title: Text(context.loc.arabicQuestion),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _qArController,
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
                  title: Text(context.loc.englishAnswer),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _aEnController,
                            maxLines: 4,
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
                  title: Text(context.loc.arabicAnswer),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _aArController,
                            maxLines: 4,
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
              final _faq = Faq(
                id: '',
                service_id: widget.model.service.id,
                q_en: _qEnController.text,
                q_ar: _qArController.text,
                a_en: _aEnController.text,
                a_ar: _aArController.text,
                video_id: '',
              );
              Navigator.pop(context, _faq);
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
