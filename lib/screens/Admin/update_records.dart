import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Firestore _firestore = Firestore.instance;

class UpdateRecords extends StatefulWidget {
  static final String id = 'update_records';

  @override
  _UpdateRecordsState createState() => _UpdateRecordsState();
}

class _UpdateRecordsState extends State<UpdateRecords> {
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
                  "Registerd Users",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                background: Image.asset(
                  'assets/images/college_1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UsersStream(),
          ],
        ),
      ),
    );
  }
}

class UsersStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final users = snapshot.data.documents;
          List<UsersDetails> userDataWidgets = [];
          for (var singleUser in users) {
            final name = singleUser.data['name'];
            final accessId = singleUser.data['id'];
            final emailId = singleUser.data['email'];
            final password = singleUser.data['password'];
            final number = singleUser.data['number'];

            final userWidget = UsersDetails(
              name: name,
              accessId: accessId,
              emailId: emailId,
              password: password,
              number: number,
            );
            userDataWidgets.add(userWidget);
          }
          return Expanded(
            child: ListView(
              children: userDataWidgets,
            ),
          );
        }
        return Center(
          child: Text('No RegisteredUsers'),
        );
      },
    );
  }
}

class UsersDetails extends StatelessWidget {
  UsersDetails(
      {this.name, this.accessId, this.emailId, this.password, this.number});
  final String name;
  final String accessId;
  final String emailId;
  final String password;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 125,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 3, color: Colors.red),
              image: DecorationImage(
                image: AssetImage('assets/images/person.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$name',
                  style: TextStyle(
                    color: Color(0xff696b9e),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.at,
                      color: Color(0xfff29a94),
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '$emailId',
                      style: TextStyle(
                        color: Color(0xff696b9e),
                        fontSize: 15,
                        letterSpacing: .3,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.university,
                      color: Color(0xfff29a94),
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '$accessId',
                      style: TextStyle(
                        color: Color(0xff696b9e),
                        fontSize: 15,
                        letterSpacing: .3,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.mobileAlt,
                      color: Color(0xfff29a94),
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '$number',
                      style: TextStyle(
                        color: Color(0xff696b9e),
                        fontSize: 15,
                        letterSpacing: .3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
