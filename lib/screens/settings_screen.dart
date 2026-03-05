import 'package:flutter/material.dart';
import '../widgets/settings_tile.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
            ),
            title: const Text('Settings'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: theme.colorScheme.primary, width: 2),
                            ),
                            child: const CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage('https://ui-avatars.com/api/?name=Sharma&background=006A60&color=fff'),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit, color: Colors.white, size: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Mr. Sharma',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ADMINISTRATOR',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Text(
                        'm.sharma@ruraledu.org',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                _buildSettingsSection('ACCOUNT SETTINGS', [
                  const SettingsTile(icon: Icons.person_outline, title: 'Personal Information', subtitle: 'Name, email, and contact details'),
                  const SettingsTile(icon: Icons.notifications_none, title: 'Notifications', subtitle: 'Manage alerts and announcements'),
                ], theme),

                const SizedBox(height: 24),
                _buildSettingsSection('APP PREFERENCES', [
                  SettingsTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Mode',
                    subtitle: '',
                    trailing: Switch(
                      value: appState.isDarkMode,
                      onChanged: (v) => appState.toggleDarkMode(v),
                      activeColor: theme.colorScheme.primary,
                    )
                  ),
                  const SettingsTile(icon: Icons.language_outlined, title: 'Language', subtitle: 'English (US)'),
                ], theme),

                const SizedBox(height: 24),
                _buildSettingsSection('PRIVACY & SECURITY', [
                  const SettingsTile(icon: Icons.lock_outline, title: 'Change Password', subtitle: ''),
                  const SettingsTile(icon: Icons.security_outlined, title: 'Privacy Center', subtitle: ''),
                ], theme),

                const SizedBox(height: 24),
                _buildSettingsSection('HELP & SUPPORT', [
                  const SettingsTile(icon: Icons.help_outline, title: 'Support Center', subtitle: ''),
                  const SettingsTile(icon: Icons.info_outline, title: 'About Rural Edu', subtitle: 'Version 1.0.2'),
                ], theme),

                const SizedBox(height: 40),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                  icon: const Icon(Icons.logout, size: 20),
                  label: const Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red, width: 1.5),
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 3,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              if (index == 0) Navigator.pushReplacementNamed(context, '/dashboard');
              if (index == 1) Navigator.pushReplacementNamed(context, '/students');
              if (index == 2) Navigator.pushReplacementNamed(context, '/analytics');
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
              BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Students'),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Analytics'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      }
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 12.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 11, 
              fontWeight: FontWeight.bold, 
              color: Colors.grey,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
