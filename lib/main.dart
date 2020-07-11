import 'package:flutter/material.dart';

import './screens/Student/result_screen.dart';
import './screens/Student/schedule_screen.dart';
import './screens/Admin/admin_dashboard.dart';
import './screens/Admin/generate_notifications.dart';
import './screens/Admin/registration_screen.dart';
import './screens/Admin/update_records.dart';
import './screens/Appointments/appointments.dart';
import './screens/Faculty/generate_notifications_facultyscreen.dart';
import './widgets/settings.dart';
import './screens/Student/student_dashboard.dart';
import './screens/Faculty/faculty_dashboard.dart';

import 'login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.indigoAccent,
        textTheme: TextTheme(
          bodyText2: TextStyle(fontFamily: 'Ubuntu'),
        ),
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        AdminDashboard.id: (context) => AdminDashboard(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        StudentDashboard.id: (context) => StudentDashboard(),
        GenerateNotifications.id: (context) => GenerateNotifications(),
        SettingsScreen.id: (context) => SettingsScreen(),
        UpdateRecords.id: (context) => UpdateRecords(),
        AppointmentsScreen.id: (context) => AppointmentsScreen(),
        FacultyDashboard.id: (context) => FacultyDashboard(),
        GenerateNotificationsFacultyScreen.id: (context) =>
            GenerateNotificationsFacultyScreen(),
        ResultScreen.id: (context) => ResultScreen(),
        ScheduleScreen.id: (context) => ScheduleScreen(),
      },
    );
  }
}
