import 'package:doctor_mobile_admin_panel/components/generic_dialog_title.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:flutter/material.dart';

class GenericConfirmationDialog extends StatelessWidget {
  const GenericConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
  });
  final String title;
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: GenericDialogTitle(title: title),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      scrollable: false,
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context, true);
          },
          label: Text(context.loc.confirm),
          icon: const Icon(Icons.check),
        ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context, null);
          },
          label: Text(context.loc.cancel),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
