import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Appointments/appointments.dart';
import './generate_notifications.dart';
import '../Admin/registration_screen.dart';
import '../Admin/update_records.dart';
import 'package:universityapp/widgets/appbar_drawer.dart';

class Activity {
  final String title;
  final IconData icon;
  Activity({
    this.title,
    this.icon,
  });
}

final List<Activity> activities = [
  Activity(title: "User Registration", icon: FontAwesomeIcons.userPlus),
  Activity(title: "Generate Notification", icon: FontAwesomeIcons.pencilRuler),
  Activity(title: "Change Password", icon: FontAwesomeIcons.pen),
  Activity(title: "Appointments", icon: FontAwesomeIcons.calendarDay),
  Activity(title: "Update Records", icon: FontAwesomeIcons.userEdit),
  Activity(title: "Delete Records", icon: FontAwesomeIcons.userMinus),
  Activity(title: "Leave Management", icon: FontAwesomeIcons.calendarMinus),
];

class AdminDashboard extends StatefulWidget {
  static final String id = 'admin_dashboard';

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String activityTitle;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void selectCategory(BuildContext context) {
    if (activityTitle == "User Registration") {
      Navigator.pushNamed(context, RegistrationScreen.id);
    }
    // if (activityTitle == "Change Password") {
    //   Navigator.pushNamed(context, RegistrationScreen.id);
    // }
    if (activityTitle == "Appointments") {
      Navigator.pushNamed(context, AppointmentsScreen.id);
    }
    if (activityTitle == "Update Records") {
      Navigator.pushNamed(context, UpdateRecords.id);
    }
    // if (activityTitle == "Delete Records") {
    //   Navigator.pushNamed(context, RegistrationScreen.id);
    // }
    // if (activityTitle == "Leave Management") {
    //   Navigator.pushNamed(context, RegistrationScreen.id);
    // }
    if (activityTitle == "Generate Notification") {
      Navigator.pushNamed(context, GenerateNotifications.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Admin'),
      ),
      drawer: AppBarDrawer(),
      body: Container(
        margin: EdgeInsets.all(18.0),
        child: _buildTitledContainer(
          "Activities",
          height: double.infinity,
          child: Expanded(
            child: GridView.count(
              crossAxisCount: 2,
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
                          const SizedBox(height: 10.0),
                          Text(
                            activity.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
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
    );
  }

  Container _buildTitledContainer(String title, {Widget child, double height}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
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
}
