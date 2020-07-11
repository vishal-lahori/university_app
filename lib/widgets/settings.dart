import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String loggedInUser;

class SettingsScreen extends StatefulWidget {
  static final String id = 'settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _dark;
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _dark = true;
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  void getCurrentUser() async {
    try {
      final FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
      if (firebaseUser != null) {
        loggedInUser = firebaseUser.email;
        print(loggedInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: _dark ? null : Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: _dark ? Colors.white : Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.moon),
              onPressed: () {
                setState(() {
                  _dark = !_dark;
                });
              },
            )
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.purple,
                    child: ListTile(
                      //onTap: () {},
                      title: Text(
                        '$loggedInUser',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          'assets/images/person.png',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.portrait,
                            color: Colors.purple,
                          ),
                          title: Text("Vishal Lahori"),
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.fiber_pin,
                            color: Colors.purple,
                          ),
                          title: Text("17BCA023"),
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.personal_video,
                            color: Colors.purple,
                          ),
                          title: Text("BCA"),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 100,
                  //   child: UserStream(),
                  // ),

                  SizedBox(height: 20.0),
                  Text(
                    "Notification Settings",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SwitchListTile(
                    activeColor: Colors.purple,
                    contentPadding: EdgeInsets.all(0),
                    value: _isSelected,
                    title: Text("Receive notification"),
                    onChanged: (bool newValue) {
                      setState(() {
                        _isSelected = newValue;
                      });
                    },
                  ),
                  SwitchListTile(
                    activeColor: Colors.purple,
                    contentPadding: EdgeInsets.all(0),
                    value: _isSelected,
                    title: Text("Allow Location"),
                    onChanged: (bool newValue) {
                      setState(() {
                        _isSelected = newValue;
                      });
                    },
                  ),
                  SwitchListTile(
                    activeColor: Colors.purple,
                    contentPadding: EdgeInsets.all(0),
                    value: _isSelected,
                    title: Text("Receive Appointment Alerts"),
                    onChanged: (bool newValue) {
                      setState(() {
                        _isSelected = newValue;
                      });
                    },
                  ),
                  SwitchListTile(
                    activeColor: Colors.purple,
                    contentPadding: EdgeInsets.all(0),
                    value: _isSelected,
                    title: Text("Receive App Updates"),
                    onChanged: (bool newValue) {
                      setState(() {
                        _isSelected = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}

// class UserStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore
//           .collection('Users')
//           .where("email", isEqualTo: loggedInUser)
//           .getDocuments(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final users = snapshot.data.documents;
//           List<Widget> userDataWidgets = [];
//           for (var singleUser in users) {
//             final name = singleUser.data['name'];
//             final accessId = singleUser.data['id'];
//             final emailId = singleUser.data['email'];
//             final password = singleUser.data['password'];
//             final number = singleUser.data['number'];

//             final userWidget = Text('name : $name \n email : $emailId');
//             userDataWidgets.add(userWidget);
//           }
//           return Expanded(
//             child: ListView(
//               children: userDataWidgets,
//             ),
//           );
//         }
//         return Center(
//           child: Text('No RegisteredUsers'),
//         );
//       },
//     );
//   }
// }
