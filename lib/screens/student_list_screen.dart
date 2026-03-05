import 'package:flutter/material.dart';
import '../widgets/student_tile.dart';
import '../main.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  String selectedFilter = 'All Students';
  String searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final theme = Theme.of(context);
        final filteredStudents = appState.students.where((student) {
          final matchesFilter = selectedFilter == 'All Students' || student['grade'] == selectedFilter;
          final matchesSearch = student['name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
              student['id']!.toLowerCase().contains(searchQuery.toLowerCase());
          return matchesFilter && matchesSearch;
        }).toList();

        return PopScope(
          canPop: false,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Rural Edu', style: TextStyle(fontWeight: FontWeight.bold)),
              centerTitle: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.lock_outline),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildFilterChip('All Students', theme),
                                _buildFilterChip('Grade 10', theme),
                                _buildFilterChip('Grade 9', theme),
                                _buildFilterChip('Grade 8', theme),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: theme.brightness == Brightness.dark ? Colors.white10 : Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.tune, size: 20, color: theme.colorScheme.primary),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          searchQuery = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search students...',
                        prefixIcon: const Icon(Icons.search, size: 20),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: theme.brightness == Brightness.dark ? Colors.white10 : Colors.grey[100],
                        suffixIcon: searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 16),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    searchQuery = '';
                                  });
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: filteredStudents.isEmpty
                        ? const Center(child: Text('No students found'))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: filteredStudents.length,
                            itemBuilder: (context, index) {
                              final student = filteredStudents[index];
                              return StudentTile(
                                name: student['name']!,
                                subtitle: 'ID: ${student['id']} • ${student['grade']}',
                                attendance: student['attendance']!,
                                imageUrl: student['image']!,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  '/student_profile',
                                  arguments: student,
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, '/add_student'),
              backgroundColor: theme.colorScheme.primary,
              child: const Icon(Icons.add, color: Colors.white),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 1,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: theme.colorScheme.primary,
              unselectedItemColor: Colors.grey,
              backgroundColor: theme.scaffoldBackgroundColor,
              onTap: (index) {
                if (index == 0) Navigator.pushReplacementNamed(context, '/dashboard');
                if (index == 2) Navigator.pushReplacementNamed(context, '/analytics');
                if (index == 3) Navigator.pushReplacementNamed(context, '/settings');
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
                BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Students'),
                BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Analytics'),
                BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildFilterChip(String label, ThemeData theme) {
    bool isSelected = selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () => setState(() => selectedFilter = label),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : (theme.brightness == Brightness.dark ? Colors.white10 : Colors.grey[100]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : (theme.brightness == Brightness.dark ? Colors.white70 : Colors.black),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
