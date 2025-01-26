import 'package:flutter/material.dart';

class GenericDialogTitle extends StatelessWidget {
  const GenericDialogTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const Spacer(),
        IconButton.outlined(
          onPressed: () async {
            Navigator.pop(context, null);
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
