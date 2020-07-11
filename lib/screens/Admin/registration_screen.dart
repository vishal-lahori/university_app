import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universityapp/screens/Admin/admin_dashboard.dart';

class RegistrationScreen extends StatefulWidget {
  static final String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Firestore _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  String userId;
  String password;
  String name;
  String accessId;
  String mobileNo;

  final _accessIdFocusNode = FocusNode();
  final _emailIdFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _numberFocusNode = FocusNode();
  final _registerBtnFocusNode = FocusNode();

  final nameController = TextEditingController();
  final accesIdController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final numberController = TextEditingController();

  @override
  void dispose() {
    _accessIdFocusNode.dispose();
    _emailIdFocusNode.dispose();
    _passwordFocusNode.dispose();
    _numberFocusNode.dispose();
    _registerBtnFocusNode.dispose();

    nameController.dispose();
    accesIdController.dispose();
    emailController.dispose();
    passwordController.dispose();
    numberController.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Add New Users",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23.0,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                background: Image.asset(
                  'assets/images/college_1.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
                    child: TextFormField(
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_accessIdFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      controller: nameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Name !!';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        name = value;
                      },
                      style: TextStyle(),
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        prefixIcon: Icon(
                          FontAwesomeIcons.user,
                          color: Colors.indigoAccent,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
                    child: TextFormField(
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailIdFocusNode);
                      },
                      focusNode: _accessIdFocusNode,
                      textInputAction: TextInputAction.next,
                      controller: accesIdController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Access Id !!';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        accessId = value;
                      },
                      style: TextStyle(),
                      decoration: InputDecoration(
                        labelText: 'Access Id',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        prefixIcon: Icon(
                          FontAwesomeIcons.university,
                          color: Colors.indigoAccent,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
                    child: TextFormField(
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      focusNode: _emailIdFocusNode,
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Email Address !!';
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Please Enter Valid Email !!';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        userId = value;
                      },
                      style: TextStyle(),
                      decoration: InputDecoration(
                        labelText: 'Email Id',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        prefixIcon: Icon(
                          FontAwesomeIcons.penAlt,
                          color: Colors.indigoAccent,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
                    child: TextFormField(
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_numberFocusNode);
                      },
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.next,
                      controller: passwordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Password !!';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      style: TextStyle(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.indigoAccent,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: Colors.indigoAccent,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
                    child: TextFormField(
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_registerBtnFocusNode);
                      },
                      focusNode: _numberFocusNode,
                      textInputAction: TextInputAction.next,
                      controller: numberController,
                      validator: (value) {
                        if (value.isEmpty) {
                          // showSpinner = false;
                          return 'Please Enter Mobile Number !!';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        mobileNo = value;
                      },
                      style: TextStyle(),
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        prefixIcon: Icon(
                          FontAwesomeIcons.mobileAlt,
                          color: Colors.indigoAccent,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 90,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: MaterialButton(
                        focusNode: _registerBtnFocusNode,
                        minWidth: 140.0,
                        height: 40,
                        color: Colors.indigo,
                        onPressed: () async {
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: userId, password: password);
                            if (newUser != null) {
                              print(newUser);

                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                              }
                              _successDialog(context);

                              _firestore.collection('Users').add({
                                'name': name,
                                'id': accessId,
                                'email': userId,
                                'password': password,
                                'number': mobileNo,
                              });
                            }
                          } catch (e) {
                            print(e);
                          }

                          nameController.clear();
                          accesIdController.clear();
                          emailController.clear();
                          passwordController.clear();
                          numberController.clear();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 10.0,
                        child: Text(
                          'Register User',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_successDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BeautifulAlertDialog();
    },
  );
}

class BeautifulAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.all(20.0),
          //height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              30.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(width: 20.0),
              Icon(
                FontAwesomeIcons.solidCheckCircle,
                color: Colors.green,
                size: 60,
              ),
              SizedBox(height: 25.0),
              Text(
                "Done!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10.0),
              Divider(
                color: Colors.black45,
              ),
              Text(
                "Registration Successful",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 19.0),
              MaterialButton(
                elevation: 5,
                child: Text("Ok"),
                color: Colors.green,
                colorBrightness: Brightness.dark,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AdminDashboard.id, (route) => false);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
