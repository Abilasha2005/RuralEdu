import 'package:flutter/material.dart';

class ReportCardScreen extends StatelessWidget {
  final Map<String, String>? studentData;

  const ReportCardScreen({super.key, this.studentData});

  @override
  Widget build(BuildContext context) {
    final name = studentData?['name'] ?? 'Aarav Gupta';
    final grade = studentData?['grade'] ?? 'Grade 10';
    final id = studentData?['id'] ?? '2023001';

    return Scaffold(
      appBar: AppBar(title: const Text('Report Card')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.school, size: 64, color: Color(0xFF006A60)),
            const SizedBox(height: 16),
            const Text(
              'RURAL EDU CENTER',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
            const Text('Academic Session 2023-24'),
            const SizedBox(height: 32),
            _buildInfoRow('Student Name', name),
            _buildInfoRow('Student ID', id),
            _buildInfoRow('Grade', grade),
            const SizedBox(height: 32),
            Table(
              border: const TableBorder(horizontalInside: BorderSide(color: Colors.grey, width: 0.5)),
              children: const [
                TableRow(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Score', style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Grade', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Mathematics')),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('85/100')),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('A')),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Science')),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('78/100')),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('B+')),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('English')),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('92/100')),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('A+')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Downloading Report Card...')),
                );
              },
              icon: const Icon(Icons.download),
              label: const Text('Download PDF'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
