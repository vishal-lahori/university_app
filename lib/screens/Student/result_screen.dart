import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ResultScreen extends StatefulWidget {
  static final String id = 'result_screen';

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ResultPages(
      sem: "SEM - 1",
      sgpa: "9.24",
      cgpa: "9.24",
      date: "NOV-17",
      sub1: "Libral Arts",
      sub2: "Fundamental of Programming",
      sub3: "Introduction to Computers",
      sub4: "Programming the Internet",
      sub5: "Programming using C",
    ),
    ResultPages(
      sem: "SEM - 2",
      sgpa: "9.21",
      cgpa: "9.22",
      date: "APR-17",
      sub1: "Art of Programming",
      sub2: "Object Oriented with C++",
      sub3: "System Analysis",
      sub4: "Values and Ethics",
      sub5: "Visual Basic Applications",
    ),
    ResultPages(
      sem: "SEM - 3",
      sgpa: "7.83",
      cgpa: "8.93",
      date: "NOV-18",
      sub1: "Art of Programming",
      sub2: "Object Oriented with C++",
      sub3: "System Analysis",
      sub4: "Values and Ethics",
      sub5: "Operating System Concepts",
    ),
    ResultPages(
      sem: "SEM - 4",
      sgpa: "6.92",
      cgpa: "8.56",
      date: "APR-19",
      sub1: "Advanced Programming",
      sub2: "Fundamentals of Commerce",
      sub3: "Operating System Concepts",
      sub4: "Values and Ethics",
      sub5: "Database Fundamentals",
    ),
    ResultPages(
      sem: "SEM - 5",
      sgpa: "6.56",
      cgpa: "7.98",
      date: "NOV-19",
      sub1: "Programming Fundamets",
      sub2: "Object Oriented using JAVA",
      sub3: "System Design and Analysis",
      sub4: "Basic English ",
      sub5: "Communication Skills",
    ),
    ResultPages(
      sem: "SEM - 6",
      sgpa: "9.00",
      cgpa: "9.00",
      date: "APR-20",
      sub1: "Artificial Intelligence",
      sub2: "Mobile Applications",
      sub3: "Minor Project",
      sub4: "Personality Development",
      sub5: "Data Science",
    ),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Scoreboard',
          style: TextStyle(fontFamily: 'Ubuntu', fontSize: 23),
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        color: Colors.black26,
        backgroundColor: Colors.black12,
        buttonBackgroundColor: Colors.black,
        height: 70,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.easeOutSine,
        items: <Widget>[
          Icon(Icons.looks_one, size: 25, color: Colors.white),
          Icon(Icons.looks_two, size: 25, color: Colors.white),
          Icon(Icons.looks_3, size: 25, color: Colors.white),
          Icon(Icons.looks_4, size: 25, color: Colors.white),
          Icon(Icons.looks_5, size: 25, color: Colors.white),
          Icon(Icons.looks_6, size: 25, color: Colors.white),
        ],
        onTap: (index) {
          onTabTapped(index);
        },
      ),
    );
  }
}

class ResultPages extends StatelessWidget {
  ResultPages({
    this.sem,
    this.sgpa,
    this.cgpa,
    this.date,
    this.sub1,
    this.sub2,
    this.sub3,
    this.sub4,
    this.sub5,
  });

  final String sem;
  final String sgpa;
  final String cgpa;
  final String date;
  final String sub1;
  final String sub2;
  final String sub3;
  final String sub4;
  final String sub5;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            elevation: 4.0,
            margin: const EdgeInsets.fromLTRB(26.0, 8.0, 26.0, 16.0),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      sem,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    trailing: Text(
                      date,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("CA101"),
                  subtitle: Text(sub1),
                  trailing: Text("AA"),
                ),
                _buildDivider(),
                ListTile(
                  title: Text("CA102"),
                  subtitle: Text(sub2),
                  trailing: Text("AA"),
                ),
                _buildDivider(),
                ListTile(
                  title: Text("CA103"),
                  subtitle: Text(sub3),
                  trailing: Text("AB"),
                ),
                _buildDivider(),
                ListTile(
                  title: Text("CA104"),
                  subtitle: Text(sub4),
                  trailing: Text("BA"),
                ),
                _buildDivider(),
                ListTile(
                  title: Text("CA105"),
                  subtitle: Text(sub5),
                  trailing: Text("AA"),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 130,
                      color: Colors.indigo,
                      child: ListTile(
                        title: Text("SGPA"),
                        subtitle: Text(
                          sgpa,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      color: Colors.indigo,
                      child: ListTile(
                        title: Text("CGPA"),
                        subtitle: Text(
                          cgpa,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
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
