import 'package:flutter/material.dart';

class AcademicRecordsScreen extends StatelessWidget {
  const AcademicRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Academic Records')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            title: Text('Mid-term Examination'),
            subtitle: Text('October 2023'),
            trailing: Text('Grade: A', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF006A60))),
          ),
          ListTile(
            title: Text('Quarterly Assessment'),
            subtitle: Text('August 2023'),
            trailing: Text('Grade: B+', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text('Monthly Test - September'),
            subtitle: Text('September 2023'),
            trailing: Text('18/20', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
