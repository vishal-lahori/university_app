import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GenerateNotificationsFacultyScreen extends StatefulWidget {
  static final String id = 'generate_notifications_facultyscreen';

  @override
  _GenerateNotificationsFacultyScreenState createState() =>
      _GenerateNotificationsFacultyScreenState();
}

class _GenerateNotificationsFacultyScreenState
    extends State<GenerateNotificationsFacultyScreen> {
  String notificationText;
  Firestore _firestore = Firestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _firebaseAuth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void notificationStream() async {
    await for (var snapshot
        in _firestore.collection('Notifications').snapshots()) {
      for (var notifications in snapshot.documents) {
        print(notifications.data);
      }
    }
  }

  void generateSnakeBar() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Notifiaction Generated !!',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.greenAccent,
        duration: Duration(seconds: 10),
        action: SnackBarAction(
            label: 'OK',
            textColor: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Generate Notifications'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 25.0),
                child: CircleAvatar(
                  child: Image.asset('assets/images/charusat_logo_2.jpg'),
                  maxRadius: 60,
                  backgroundColor: Colors.transparent,
                ),
              ),
              Container(
                padding: EdgeInsets.all(25.0),
                child: TextField(
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  scrollPhysics:
                      ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  onChanged: (value) {
                    notificationText = value;
                  },
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Notification Message..',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.subtitles,
                        color: Colors.indigoAccent,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 90,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    minWidth: 130.0,
                    height: 45,
                    color: Colors.indigo,
                    onPressed: () {
                      _firestore.collection('StudentsNotifications').add({
                        'sender': loggedInUser.email,
                        'text': notificationText
                      });
                      notificationStream();
                      generateSnakeBar();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 7.0,
                    child: Text(
                      'Notify Students',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
