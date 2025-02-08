import 'package:doctor_mobile_admin_panel/components/generic_dialog_title.dart';
import 'package:doctor_mobile_admin_panel/components/thin_divider.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/base_textfield_validator.dart';
import 'package:doctor_mobile_admin_panel/models/article_paragraph.dart';
import 'package:flutter/material.dart';

class CreateParagraphDialog extends StatefulWidget {
  const CreateParagraphDialog({super.key, required this.article_id});
  final String article_id;

  @override
  State<CreateParagraphDialog> createState() => _CreateParagraphDialogState();
}

class _CreateParagraphDialogState extends State<CreateParagraphDialog> {
  final formKey = GlobalKey<FormState>(debugLabel: 'article-create-form');

  late final TextEditingController _titleEnController;
  late final TextEditingController _titleArController;
  late final TextEditingController _descEnController;
  late final TextEditingController _descArController;

  @override
  void initState() {
    super.initState();
    _titleEnController = TextEditingController();
    _titleArController = TextEditingController();
    _descEnController = TextEditingController();
    _descArController = TextEditingController();
  }

  @override
  void dispose() {
    _titleEnController.dispose();
    _titleArController.dispose();
    _descEnController.dispose();
    _descArController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: GenericDialogTitle(title: context.loc.createParagraph),
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
                  title: Text(context.loc.englishTitle),
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
                  title: Text(context.loc.arabicTitle),
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
                  title: Text(context.loc.englishBody),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLines: 5,
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
                  title: Text(context.loc.arabicBody),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLines: 5,
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
              final _paragraph = ArticleParagraph(
                id: '',
                article_id: widget.article_id,
                title_en: _titleEnController.text,
                title_ar: _titleArController.text,
                body_en: _descEnController.text,
                body_ar: _descArController.text,
              );
              Navigator.pop(context, _paragraph);
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
