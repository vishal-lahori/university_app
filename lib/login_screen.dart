import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:flutter/material.dart';
import 'package:universityapp/screens/Faculty/faculty_dashboard.dart';
import './screens/Admin/admin_dashboard.dart';
import './screens/Student/student_dashboard.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String userId;
  String password;
  String adminEmail = "admin@gmail.com";
  String facultyEmail = "faculty@gmail.com";

  final _passwordFocusNode = FocusNode();
  final _loginBtnFocusNode = FocusNode();

  bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();

  bool _visibility = true;
  void _toggleVisibility() {
    setState(() {
      _visibility = !_visibility;
    });
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _loginBtnFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(context),
    );
  }

  Widget _buildPageContent(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 35.0),
            TyperAnimatedTextKit(
              text: ["CHARUSAT"],
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                fontFamily: 'Special_Elite',
                fontSize: 35.0,
              ),
              speed: Duration(milliseconds: 200),
            ),
            SizedBox(height: 35.0),
            _buildLoginForm(),
          ],
        ),
      ),
    );
  }

  Container _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 450,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
                color: Colors.white,
              ),
              child: Form(
                autovalidate: true,
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            showSpinner = false;
                            return 'Please Enter Email Address !!';
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'Please Enter Valid Email !!';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          userId = value;
                        },
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Ubuntu",
                        ),
                        decoration: InputDecoration(
                          labelText: 'User Id',
                          labelStyle: TextStyle(color: Colors.indigo),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.indigo, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.indigoAccent,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_loginBtnFocusNode);
                        },
                        textInputAction: TextInputAction.next,
                        focusNode: _passwordFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            showSpinner = false;
                            return 'Please Enter Your Password !!';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: _visibility,
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                          fontFamily: "Ubuntu",
                        ),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.indigo),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.indigo, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.indigoAccent,
                          ),
                          suffixIcon: IconButton(
                            color: Colors.indigoAccent,
                            onPressed: _toggleVisibility,
                            icon: _visibility
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                child: Image.asset('assets/images/charusat_logo_2.jpg'),
                maxRadius: 50,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          Container(
            height: 470,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                focusNode: _loginBtnFocusNode,
                minWidth: 130.0,
                height: 45,
                color: Colors.indigo,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: userId, password: password);
                    if (user != null) {
                      if (userId == adminEmail) {
                        Navigator.pushReplacementNamed(
                            context, AdminDashboard.id);
                      } else if (userId == facultyEmail) {
                        Navigator.pushReplacementNamed(
                            context, FacultyDashboard.id);
                      } else {
                        Navigator.pushReplacementNamed(
                            context, StudentDashboard.id);
                      }
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 5.0,
                child: Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.quadraticBezierTo(size.width, 0.0, size.width - 20.0, 0.0);
    path.lineTo(40.0, 70.0);
    path.quadraticBezierTo(10.0, 85.0, 0.0, 120.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
