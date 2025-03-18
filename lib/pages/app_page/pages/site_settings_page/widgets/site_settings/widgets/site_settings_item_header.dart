import 'package:flutter/material.dart';

class SiteSettingsItemHeader extends StatelessWidget {
  const SiteSettingsItemHeader({
    super.key,
    required this.header,
    this.forBackground = false,
    this.onPressed,
  });
  final String header;
  final bool forBackground;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(width: 10),
            CircleAvatar(
              radius: 16,
              child: Text('*'),
            ),
            SizedBox(width: 10),
            Text(header),
            if (forBackground) ...[
              const Spacer(),
              IconButton.outlined(
                onPressed: onPressed ?? () {},
                icon: const Icon(Icons.add),
              ),
              SizedBox(width: 10),
            ]
          ],
        ),
      ),
    );
  }
}
