import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/settings.dart';
import '../login_screen.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarDrawer extends StatefulWidget {
  @override
  _AppBarDrawerState createState() => _AppBarDrawerState();
}

class _AppBarDrawerState extends State<AppBarDrawer> {
  final _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
      if (firebaseUser != null) {
        loggedInUser = firebaseUser;
        print(loggedInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade500,
    );
  }

  void _openCaller(int number) async {
    var dialer = "tel:${number.toString()}";
    if (await canLaunch(dialer)) {
      await launch(dialer);
    } else {
      throw "Could not place call.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 30.0),
                  child: CircleAvatar(
                    radius: 25,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: Colors.indigoAccent[700],
                        size: 30.0,
                      ),
                      onPressed: () {
                        _firebaseAuth.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.id, (route) => false);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 90.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColorLight
                      ],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      'assets/images/person.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Welcome User",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  'user007',
                  style: TextStyle(
                    color: Colors.indigoAccent[100],
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.home,
                    size: 28,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _buildDivider(),
                ListTile(
                  onTap: () {
                    Navigator.popAndPushNamed(context, SettingsScreen.id);
                  },
                  leading: Icon(
                    Icons.settings,
                    size: 28,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _buildDivider(),
                ListTile(
                  onTap: () {
                    _openCaller(9067488826);
                  },
                  leading: Icon(
                    Icons.mail_outline,
                    size: 28,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Contact Us',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _buildDivider(),
                ListTile(
                  onTap: () {
                    _alertDialog(context);
                  },
                  leading: Icon(
                    FontAwesomeIcons.university,
                    size: 28,
                    color: Colors.white,
                  ),
                  title: Text(
                    'About Us',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _buildDivider(),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.help_outline,
                    size: 28,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Help',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_alertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BeautifulAlertDialog();
    },
  );
}

class BeautifulAlertDialog extends StatelessWidget {
  _launchURL() async {
    var url = 'https://www.charusat.ac.in/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(right: 16.0),
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75),
                  bottomLeft: Radius.circular(75),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              CircleAvatar(
                radius: 55,
                backgroundColor: Colors.grey.shade200,
                child: Image.asset(
                  'assets/images/info_icon.png',
                  fit: BoxFit.fill,
                  width: 200,
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Alert!",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10.0),
                    Flexible(
                      child: Text(
                        "Open University's website to know more about us?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Text("No"),
                            color: Colors.red,
                            colorBrightness: Brightness.dark,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: RaisedButton(
                            child: Text("Yes"),
                            color: Colors.green,
                            colorBrightness: Brightness.dark,
                            onPressed: () {
                              _launchURL();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
