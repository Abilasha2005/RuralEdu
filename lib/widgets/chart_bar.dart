import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double heightFactor;
  final double width;
  final Color? color;

  const ChartBar({
    super.key,
    required this.label,
    required this.heightFactor,
    this.width = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 100 * heightFactor,
          width: width,
          decoration: BoxDecoration(
            color: color ?? const Color(0xFF006A60).withOpacity(0.8),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}
