import 'package:flutter/material.dart';
import '../main.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  String _selectedGrade = 'Grade 10';

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _saveStudent() {
    if (_nameController.text.isEmpty || _idController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in Name and ID')),
      );
      return;
    }

    appState.addStudent({
      'id': _idController.text,
      'name': _nameController.text,
      'grade': _selectedGrade,
      'attendance': '100%',
      'image': 'https://i.pravatar.cc/150?u=${_idController.text}',
      'parent': '9876543210',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Student added successfully!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add New Student'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF006A60).withOpacity(0.3), width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 54,
                    backgroundColor: Color(0xFFF5F5F5),
                    child: Icon(Icons.person, size: 60, color: Color(0xFFBDBDBD)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF006A60),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Student Photo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Text('Upload a clear headshot', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 32),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: "Enter student's full name",
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'Student ID',
                hintText: 'e.g. STU-2023-001',
                prefixIcon: Icon(Icons.badge_outlined),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedGrade,
              decoration: const InputDecoration(
                labelText: 'Select Grade',
                prefixIcon: Icon(Icons.school_outlined),
              ),
              items: ['Grade 8', 'Grade 9', 'Grade 10'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedGrade = val);
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _saveStudent,
              child: const Text('Save Student Record', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
