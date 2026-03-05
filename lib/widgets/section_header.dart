import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String action;
  final VoidCallback? onActionPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.action = '',
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        if (action.isNotEmpty)
          TextButton(
            onPressed: onActionPressed,
            child: Text(
              action,
              style: const TextStyle(
                color: Color(0xFF006A60),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
