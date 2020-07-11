import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universityapp/screens/Appointments/appointments.dart';
import 'package:universityapp/screens/Student/result_screen.dart';
import 'package:universityapp/screens/Student/schedule_screen.dart';
import 'package:universityapp/widgets/appbar_drawer.dart';

Firestore _firestore = Firestore.instance;

class Activity {
  final String title;
  final IconData icon;
  Activity({
    this.title,
    this.icon,
  });
}

final List<Activity> activities = [
  Activity(title: "Results", icon: FontAwesomeIcons.listOl),
  Activity(title: "Schedule", icon: FontAwesomeIcons.calendar),
  Activity(title: "Appointments", icon: FontAwesomeIcons.calendarDay),
  Activity(title: "Attendance", icon: FontAwesomeIcons.chartBar),
  Activity(title: "Leave", icon: FontAwesomeIcons.calendarMinus),
  Activity(title: "Submissions", icon: FontAwesomeIcons.copy),
];

class StudentDashboard extends StatefulWidget {
  static final String id = 'student_dashboard';

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  String activityTitle;

  void selectCategory(BuildContext context) {
    if (activityTitle == "Results") {
      Navigator.pushNamed(context, ResultScreen.id);
    }
    if (activityTitle == "Schedule") {
      Navigator.pushNamed(context, ScheduleScreen.id);
    }
    if (activityTitle == "Appointments") {
      Navigator.pushNamed(context, AppointmentsScreen.id);
    }
    // if (activityTitle == "Attendance") {
    //   Navigator.pushNamed(context, UpdateRecords.id);
    // }
    // if (activityTitle == "Submissions") {
    //   Navigator.pushNamed(context, RegistrationScreen.id);
    // }
    // if (activityTitle == "Leave") {
    //   Navigator.pushNamed(context, RegistrationScreen.id);
    // }
  }

  Container _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade600,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
      ),
      drawer: AppBarDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.indigo,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TyperAnimatedTextKit(
                    text: ["Notifications"],
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    ),
                    speed: Duration(milliseconds: 180),
                  ),
                  NotificationFromAdminStream(),
                  Container(
                    margin: EdgeInsets.only(left: 270),
                    width: 90,
                    color: Colors.black38,
                    child: Text(
                      '- From Admin',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  _buildDivider(),
                  NotificationFromFacultyStream(),
                  Container(
                    margin: EdgeInsets.only(left: 260),
                    width: 100,
                    color: Colors.black38,
                    child: Text(
                      '- From Faculties',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 5.0),
              child: _buildTitledContainer(
                "Activities",
                height: 300,
                child: Expanded(
                  child: GridView.count(
                    padding: EdgeInsets.only(top: 10),
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    children: activities
                        .map(
                          (activity) => InkWell(
                            onTap: () {
                              activityTitle = activity.title;
                              selectCategory(context);
                            },
                            splashColor: Colors.indigoAccent,
                            borderRadius: BorderRadius.circular(15),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.black38,
                                  child: activity.icon != null
                                      ? Icon(
                                          activity.icon,
                                          size: 27.0,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                                const SizedBox(height: 7.0),
                                Text(
                                  activity.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container _buildTitledContainer(String title, {Widget child, double height}) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    width: double.infinity,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.indigo,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TyperAnimatedTextKit(
          text: [title],
          textAlign: TextAlign.center,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
          ),
          speed: Duration(milliseconds: 100),
        ),
        if (child != null) ...[const SizedBox(height: 10.0), child]
      ],
    ),
  );
}

class NotificationFromFacultyStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('StudentsNotifications').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white54,
              ),
            ),
          );
        }
        final notifications = snapshot.data.documents;
        List<Text> notificationWidgets = [];
        for (var notification in notifications) {
          final notificationText = notification.data['text'];
          final notificationWidget = Text(
            '$notificationText',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Raleway',
            ),
          );
          notificationWidgets.add(notificationWidget);
        }
        return notificationWidgets.isEmpty
            ? Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  margin:
                      EdgeInsets.only(left: 10, top: 10, right: 90, bottom: 15),
                  child: Text(
                    'No New Notifications',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              )
            : Expanded(
                child: ListView(
                  padding: EdgeInsets.only(left: 20.0, top: 15.0),
                  children: notificationWidgets,
                ),
              );
      },
    );
  }
}

class NotificationFromAdminStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Notifications').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white54,
              ),
            ),
          );
        }
        final notifications = snapshot.data.documents.reversed;
        List<Text> notificationWidgets = [];
        for (var notification in notifications) {
          final notificationText = notification.data['text'];
          final notificationWidget = Text(
            '$notificationText',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Raleway',
            ),
          );
          notificationWidgets.add(notificationWidget);
        }
        return notificationWidgets.isEmpty
            ? Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  margin:
                      EdgeInsets.only(left: 10, top: 10, right: 90, bottom: 15),
                  child: Text(
                    'No New Notifications',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              )
            : Expanded(
                child: ListView(
                  padding: EdgeInsets.only(left: 20.0, top: 15.0),
                  children: notificationWidgets,
                ),
              );
      },
    );
  }
}
