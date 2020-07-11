import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Faculty/generate_notifications_facultyscreen.dart';
import '../Appointments/appointments.dart';
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
  Activity(title: "Generate Notification", icon: FontAwesomeIcons.pencilRuler),
  Activity(title: "Submissions", icon: FontAwesomeIcons.copy),
];

class FacultyDashboard extends StatefulWidget {
  static final String id = 'faculty_dashboard';

  @override
  _FacultyDashboardState createState() => _FacultyDashboardState();
}

class _FacultyDashboardState extends State<FacultyDashboard> {
  String activityTitle;

  void selectCategory(BuildContext context) {
    // if (activityTitle == "Results") {
    //   Navigator.pushNamed(context, RegistrationScreen.id);
    // }
    // if (activityTitle == "Schedule") {
    //   Navigator.pushNamed(context, RegistrationScreen.id);
    // }
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
    if (activityTitle == "Generate Notification") {
      Navigator.pushNamed(context, GenerateNotificationsFacultyScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty Dashboard'),
      ),
      drawer: AppBarDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.indigo,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Notifications",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
                  ),
                  NotificationStream(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15.0, left: 15.0),
              child: _buildTitledContainer(
                "Activities",
                height: 350,
                child: Expanded(
                  child: GridView.count(
                    padding: EdgeInsets.only(top: 10),
                    //physics: NeverScrollableScrollPhysics(),
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
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
        ),
        if (child != null) ...[const SizedBox(height: 10.0), child]
      ],
    ),
  );
}

class NotificationStream extends StatelessWidget {
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
                  alignment: Alignment.center,
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
