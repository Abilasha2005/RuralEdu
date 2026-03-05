import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/chart_bar.dart';
import '../main.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String selectedTab = 'Students';

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final theme = Theme.of(context);
        return PopScope(
          canPop: false,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
              ),
              title: const Text('Academic Analytics'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Custom Tabs
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildTab('Students', theme),
                          _buildTab('Attendance', theme),
                          _buildTab('Resources', theme),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        Expanded(child: _buildMetricCard('Overall Average', '84.2%', '+2%', Colors.green, Icons.analytics_outlined, theme)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildMetricCard('Weekly Growth', '+12%', '+4%', Colors.green, Icons.trending_up, theme)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildMetricCard('Avg. Attendance', '91%', '-5%', Colors.red, Icons.event_available, theme),
                    const SizedBox(height: 32),
                    const SectionHeader(title: 'Monthly Attendance Average'),
                    const SizedBox(height: 20),
                    Container(
                      height: 180,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ChartBar(label: 'Jan', heightFactor: 0.6, width: 32),
                          ChartBar(label: 'Feb', heightFactor: 0.8, width: 32),
                          ChartBar(label: 'Mar', heightFactor: 0.7, width: 32),
                          ChartBar(label: 'Apr', heightFactor: 0.9, width: 32),
                          ChartBar(label: 'May', heightFactor: 0.85, width: 32),
                          ChartBar(label: 'Jun', heightFactor: 0.4, width: 32),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const SectionHeader(title: 'Top Performing Students', action: 'View All'),
                    _buildTopStudent('Ananya Sharma', 'Grade 10 • Maths Group', '98.4%', 'https://ui-avatars.com/api/?name=Ananya+Sharma&background=006A60&color=fff', theme),
                    _buildTopStudent('Rajesh Kumar', 'Grade 10 • Science Group', '97.2%', 'https://ui-avatars.com/api/?name=Rajesh+Kumar&background=006A60&color=fff', theme),
                    const SizedBox(height: 32),
                    const SectionHeader(title: 'Recent Exam Results', action: 'View All'),
                    _buildExamResult('Mathematics', 'Oct 15, 2023', '78/100', Colors.blue, theme),
                    _buildExamResult('Physics', 'Oct 12, 2023', '85/100', Colors.orange, theme),
                    _buildExamResult('History', 'Oct 10, 2023', '92/100', Colors.green, theme),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 2,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: theme.colorScheme.primary,
              unselectedItemColor: Colors.grey,
              backgroundColor: theme.scaffoldBackgroundColor,
              onTap: (index) {
                if (index == 0) Navigator.pushReplacementNamed(context, '/dashboard');
                if (index == 1) Navigator.pushReplacementNamed(context, '/students');
                if (index == 3) Navigator.pushReplacementNamed(context, '/settings');
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
                BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Students'),
                BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Analytics'),
                BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildTab(String label, ThemeData theme) {
    bool isSelected = selectedTab == label;
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = label),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isSelected ? theme.colorScheme.primary : theme.dividerColor.withOpacity(0.2)),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? theme.colorScheme.primary : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String trend, Color trendColor, IconData icon, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 20, color: theme.colorScheme.primary),
              Text(trend, style: TextStyle(color: trendColor, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTopStudent(String name, String subtitle, String score, String imageUrl, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          Text(score, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildExamResult(String subject, String date, String score, Color color, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 4),
              Text(date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(score, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
