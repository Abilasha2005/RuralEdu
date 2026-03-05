import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/performance_item.dart';
import '../widgets/summary_stat.dart';

class StudentProfileScreen extends StatelessWidget {
  final Map<String, String>? studentData;

  const StudentProfileScreen({super.key, this.studentData});

  @override
  Widget build(BuildContext context) {
    final name = studentData?['name'] ?? 'Aarav Gupta';
    final id = studentData?['id'] ?? '2023001';
    final grade = studentData?['grade'] ?? 'Grade 10';
    final attendance = studentData?['attendance'] ?? '94%';
    final image = studentData?['image'] ?? 'https://ui-avatars.com/api/?name=Aarav+Gupta&background=006A60&color=fff';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Student Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF006A60)),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(image),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'ID: $id',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              '$grade • Section A',
              style: const TextStyle(color: Color(0xFF006A60), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 32),
            // Attendance Section
            SectionHeader(
              title: 'Attendance Summary',
              action: 'View Details',
              onActionPressed: () => Navigator.pushNamed(context, '/attendance_details'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SummaryStat(
                  title: 'Attendance Rate',
                  value: attendance,
                  sub: '+2%',
                  color: Colors.green,
                  icon: Icons.trending_up,
                ),
                const SizedBox(width: 16),
                const SummaryStat(
                  title: 'Present Days',
                  value: '168/180',
                  sub: '12 Absence',
                  color: Colors.orange,
                  icon: Icons.calendar_today,
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Academic Section
            SectionHeader(
              title: 'Academic Performance',
              action: 'View Records',
              onActionPressed: () => Navigator.pushNamed(context, '/academic_records'),
            ),
            const SizedBox(height: 16),
            const PerformanceItem(subject: 'Mathematics', progress: 0.85, score: '85/100', color: Colors.blue),
            const PerformanceItem(subject: 'Science', progress: 0.78, score: '78/100', color: Colors.orange),
            const PerformanceItem(subject: 'English Language', progress: 0.92, score: '92/100', color: Colors.green),
            const SizedBox(height: 32),
            // Progress Chart
            const SectionHeader(title: 'Overall Progress'),
            const SizedBox(height: 16),
            Container(
              height: 180,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[100]!),
              ),
              child: CustomPaint(
                painter: ProgressChartPainter(),
              ),
            ),
            const SizedBox(height: 40),
            // Bottom Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/report_card',
                      arguments: studentData,
                    ),
                    icon: const Icon(Icons.description_outlined, size: 20),
                    label: const Text(
                      'Report Card',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFF006A60)),
                      foregroundColor: const Color(0xFF006A60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Message sent to parent of $name')),
                      );
                    },
                    icon: const Icon(Icons.message_outlined, size: 20, color: Colors.white),
                    label: const Text(
                      'Message Parent',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF006A60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class ProgressChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF006A60)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.7, size.width * 0.4, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.3, size.width * 0.8, size.height * 0.4);
    path.lineTo(size.width, size.height * 0.2);

    canvas.drawPath(path, paint);

    final dotPaint = Paint()..color = const Color(0xFF006A60);
    canvas.drawCircle(Offset(size.width, size.height * 0.2), 5, dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
