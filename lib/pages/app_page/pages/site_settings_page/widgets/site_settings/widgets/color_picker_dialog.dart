import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({super.key});

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color _pickerColor = Color(0xffffffff);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: _pickerColor,
          onColorChanged: (color) {
            setState(() {
              _pickerColor = color;
            });
          },
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        IconButton.outlined(
          onPressed: () {
            Navigator.pop(context, _pickerColor);
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
