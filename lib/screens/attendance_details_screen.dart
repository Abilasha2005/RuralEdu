import 'package:flutter/material.dart';

class AttendanceDetailsScreen extends StatelessWidget {
  const AttendanceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Details')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 20,
        itemBuilder: (context, index) {
          final date = DateTime.now().subtract(Duration(days: index));
          final isPresent = index % 5 != 0;
          return ListTile(
            leading: Icon(
              isPresent ? Icons.check_circle : Icons.cancel,
              color: isPresent ? Colors.green : Colors.red,
            ),
            title: Text('${date.day}/${date.month}/${date.year}'),
            trailing: Text(isPresent ? 'Present' : 'Absent'),
          );
        },
      ),
    );
  }
}
