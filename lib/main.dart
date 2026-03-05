import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/add_student_screen.dart';
import 'screens/student_list_screen.dart';
import 'screens/student_profile_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/attendance_details_screen.dart';
import 'screens/academic_records_screen.dart';
import 'screens/report_card_screen.dart';

void main() {
  runApp(const RuralEduApp());
}

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  List<Map<String, String>> students = [
    {'id': '2023001', 'name': 'Aarav Gupta', 'grade': 'Grade 10', 'attendance': '94%', 'image': 'https://ui-avatars.com/api/?name=Aarav+Gupta&background=006A60&color=fff', 'parent': '9876543210'},
    {'id': '2023002', 'name': 'Ishaan Sharma', 'grade': 'Grade 10', 'attendance': '88%', 'image': 'https://ui-avatars.com/api/?name=Ishaan+Sharma&background=006A60&color=fff', 'parent': '9876543211'},
    {'id': '2023003', 'name': 'Ananya Singh', 'grade': 'Grade 10', 'attendance': '92%', 'image': 'https://ui-avatars.com/api/?name=Ananya+Singh&background=006A60&color=fff', 'parent': '9876543212'},
    {'id': '2023004', 'name': 'Rohan Verma', 'grade': 'Grade 10', 'attendance': '85%', 'image': 'https://ui-avatars.com/api/?name=Rohan+Verma&background=006A60&color=fff', 'parent': '9876543213'},
    {'id': '2023005', 'name': 'Kriti Das', 'grade': 'Grade 10', 'attendance': '90%', 'image': 'https://ui-avatars.com/api/?name=Kriti+Das&background=006A60&color=fff', 'parent': '9876543214'},
  ];

  bool isAttendanceMarked = false;
  bool isDarkMode = false;

  void markAttendance() {
    isAttendanceMarked = true;
    notifyListeners();
  }

  void addStudent(Map<String, String> student) {
    students.insert(0, student);
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }
}

final appState = AppState();

class RuralEduApp extends StatelessWidget {
  const RuralEduApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        return MaterialApp(
          title: 'Rural Edu',
          debugShowCheckedModeBanner: false,
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF006A60),
              primary: const Color(0xFF006A60),
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: Colors.grey[50],
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              centerTitle: true,
            ),
            cardTheme: const CardThemeData(color: Colors.white),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF006A60),
              primary: const Color(0xFF006A60),
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: const Color(0xFF121212),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1E1E1E),
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
            cardTheme: const CardThemeData(color: Color(0xFF1E1E1E)),
          ),
          initialRoute: '/dashboard',
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) {
                switch (settings.name) {
                  case '/': return const LoginScreen();
                  case '/signup': return const SignupScreen();
                  case '/dashboard': return const DashboardScreen();
                  case '/add_student': return const AddStudentScreen();
                  case '/students': return const StudentListScreen();
                  case '/student_profile':
                    return StudentProfileScreen(studentData: settings.arguments as Map<String, String>?);
                  case '/analytics': return const AnalyticsScreen();
                  case '/settings': return const SettingsScreen();
                  case '/attendance_details': return const AttendanceDetailsScreen();
                  case '/academic_records': return const AcademicRecordsScreen();
                  case '/report_card':
                    return ReportCardScreen(studentData: settings.arguments as Map<String, String>?);
                  default: return const DashboardScreen();
                }
              },
              settings: settings,
            );
          },
        );
      },
    );
  }
}
