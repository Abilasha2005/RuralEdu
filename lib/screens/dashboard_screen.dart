import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';
import '../widgets/chart_bar.dart';
import '../widgets/activity_item.dart';
import '../main.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _trendFilter = 'Past 7 days';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.width < 400;

    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false, // Removes the back button
            title: Text(
              'Rural Edu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.colorScheme.primary, width: 1.5),
                  ),
                  child: const CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage('https://ui-avatars.com/api/?name=Sharma&background=006A60&color=fff'),
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, '/settings'),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome back, Mr. Sharma!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Managing Rural Education Center # Sector 24',
                  style: TextStyle(
                    color: theme.brightness == Brightness.dark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 28),
                // Stat Grid - Responsive Layout
                if (isSmallScreen)
                  Column(
                    children: [
                      StatCard(
                        title: 'Total Students',
                        value: '${appState.students.length}',
                        trend: '+5%',
                        trendColor: Colors.green,
                        icon: Icons.people_outline,
                        fullWidth: true,
                      ),
                      const SizedBox(height: 16),
                      StatCard(
                        title: 'Today Attendance',
                        value: appState.isAttendanceMarked ? '95%' : '85%',
                        trend: appState.isAttendanceMarked ? '+10%' : '-2%',
                        trendColor: appState.isAttendanceMarked ? Colors.green : Colors.red,
                        icon: Icons.calendar_today_outlined,
                        fullWidth: true,
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      StatCard(
                        title: 'Total Students',
                        value: '${appState.students.length}',
                        trend: '+5%',
                        trendColor: Colors.green,
                        icon: Icons.people_outline,
                      ),
                      const SizedBox(width: 16),
                      StatCard(
                        title: 'Today Attendance',
                        value: appState.isAttendanceMarked ? '95%' : '85%',
                        trend: appState.isAttendanceMarked ? '+10%' : '-2%',
                        trendColor: appState.isAttendanceMarked ? Colors.green : Colors.red,
                        icon: Icons.calendar_today_outlined,
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                const StatCard(
                  title: 'Pending Reports',
                  value: '3',
                  trend: 'New Tasks',
                  trendColor: Colors.orange,
                  icon: Icons.assignment_outlined,
                  fullWidth: true,
                ),
                const SizedBox(height: 28),
                // Action Buttons
                ElevatedButton.icon(
                  onPressed: appState.isAttendanceMarked
                      ? null
                      : () {
                          appState.markAttendance();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Attendance marked successfully!')),
                          );
                        },
                  icon: Icon(
                    appState.isAttendanceMarked ? Icons.check : Icons.check_circle_outline,
                    size: 20,
                    color: Colors.white,
                  ),
                  label: Text(
                    appState.isAttendanceMarked ? 'Attendance Marked' : 'Mark Attendance',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appState.isAttendanceMarked ? Colors.grey : theme.colorScheme.primary,
                    disabledBackgroundColor: Colors.grey[400],
                    minimumSize: const Size(double.infinity, 56),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/add_student'),
                  icon: const Icon(Icons.person_add_outlined, size: 20),
                  label: const Text('Add New Student', style: TextStyle(fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    side: BorderSide(color: theme.colorScheme.primary),
                    foregroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 32),
                // Chart Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Attendance Trends', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    PopupMenuButton<String>(
                      onSelected: (String value) {
                        setState(() {
                          _trendFilter = value;
                        });
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(value: 'Past 7 days', child: Text('Past 7 days')),
                        const PopupMenuItem<String>(value: 'Monthly', child: Text('Monthly')),
                        const PopupMenuItem<String>(value: 'Yearly', child: Text('Yearly')),
                      ],
                      child: Row(
                        children: [
                          Text(_trendFilter, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 160,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark ? Colors.white10 : Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: _getTrendBars(),
                  ),
                ),
                const SizedBox(height: 32),
                const Text('Recent Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                if (appState.isAttendanceMarked)
                  const ActivityItem(
                    title: 'Attendance Completed',
                    subtitle: 'Today | Just now',
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),
                const ActivityItem(
                  title: 'Attendance Completed',
                  subtitle: 'Monday, Oct 24, 2023 | 09:15 AM',
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                const ActivityItem(
                  title: 'New Student Registered',
                  subtitle: 'Monday, Oct 24, 2023 | 08:30 AM',
                  icon: Icons.person_add,
                  color: Colors.blue,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: Colors.grey,
            backgroundColor: theme.scaffoldBackgroundColor,
            showUnselectedLabels: true,
            onTap: (index) {
              if (index == 1) Navigator.pushReplacementNamed(context, '/students');
              if (index == 2) Navigator.pushReplacementNamed(context, '/analytics');
              if (index == 3) Navigator.pushReplacementNamed(context, '/settings');
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: 'Dashboard'),
              BottomNavigationBarItem(icon: Icon(Icons.people_outline), activeIcon: Icon(Icons.people), label: 'Students'),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), activeIcon: Icon(Icons.bar_chart), label: 'Analytics'),
              BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _getTrendBars() {
    if (_trendFilter == 'Past 7 days') {
      return const [
        ChartBar(label: 'Mon', heightFactor: 0.8),
        ChartBar(label: 'Tue', heightFactor: 0.6),
        ChartBar(label: 'Wed', heightFactor: 0.9),
        ChartBar(label: 'Thu', heightFactor: 0.7),
        ChartBar(label: 'Fri', heightFactor: 0.85),
        ChartBar(label: 'Sat', heightFactor: 0.4),
        ChartBar(label: 'Sun', heightFactor: 0.0),
      ];
    } else if (_trendFilter == 'Monthly') {
      return const [
        ChartBar(label: 'W1', heightFactor: 0.7),
        ChartBar(label: 'W2', heightFactor: 0.85),
        ChartBar(label: 'W3', heightFactor: 0.6),
        ChartBar(label: 'W4', heightFactor: 0.95),
      ];
    } else {
      return const [
        ChartBar(label: 'Q1', heightFactor: 0.6),
        ChartBar(label: 'Q2', heightFactor: 0.75),
        ChartBar(label: 'Q3', heightFactor: 0.9),
        ChartBar(label: 'Q4', heightFactor: 0.8),
      ];
    }
  }
}
