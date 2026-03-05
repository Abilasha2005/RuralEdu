import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  final String name;
  final String subtitle;
  final String attendance;
  final String imageUrl;
  final VoidCallback onTap;

  const StudentTile({
    super.key,
    required this.name,
    required this.subtitle,
    required this.attendance,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.event_available, size: 14, color: Colors.green),
                const SizedBox(width: 4),
                Text('Attendance: $attendance',
                    style: const TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}
