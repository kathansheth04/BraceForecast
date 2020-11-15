import 'dart:async';
import 'package:defhacks/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:defhacks/Screens/clinics.dart';
import 'package:defhacks/Screens/dashboard.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(Clinics());
}

class Clinics extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: clinics(title: 'Flutter Demo Home Page'),
    );
  }
}

class clinics extends StatefulWidget {
  clinics({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<clinics> {
  @override
  void initState() {
    super.initState();
  }

  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Main',
      style: optionStyle,
    ),
    Text(
      'Index 1: Clinics',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        _selectedIndex = 0;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        _selectedIndex = 1;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Clinics()));
      }
    });
  }

  _launchURL(String uri) async {
    String url = 'https://maps.google.com/' + uri.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF81D4FA),
        title: Text('Clinics Near You'),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut().then((value) =>
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginScreen())));
                  },
                  child: Icon(Icons.portrait_rounded)))
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Main"),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            label: "Clinics",
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: Container(
          child: new SingleChildScrollView(
              child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(65, 65, 65, 65),
            child: new Column(
              children: [
                Card(
                    clipBehavior: Clip.antiAlias,
                    color: Color(0xFF81D4FA),
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: ListTile(
                          title: new Center(
                            child: Text(
                              "Milpitas Dental Center",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            color: new Color(0x000000),
                            onPressed: () {
                              _launchURL("995+County+Hwy+G4+STE+215");
                            },
                            child: new Icon(Icons.room),
                          ),
                          FlatButton(
                            color: new Color(0x000000),
                            onPressed: () {
                              // Perform some action
                            },
                            child: const Icon(Icons.phone),
                          ),
                        ],
                      ),
                    ])),
                Card(
                    margin: new EdgeInsets.symmetric(vertical: 20),
                    clipBehavior: Clip.antiAlias,
                    color: Color(0xFF81D4FA),
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: ListTile(
                          title: new Center(
                            child: Text(
                              "Milpitas Town Center Dental Care",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            color: new Color(0x000000),
                            onPressed: () {
                              // Perform some action
                            },
                            child: new Icon(Icons.room),
                          ),
                          FlatButton(
                            color: new Color(0x000000),
                            onPressed: () {
                              // Perform some action
                            },
                            child: const Icon(Icons.phone),
                          ),
                        ],
                      ),
                    ])),
                Card(
                    clipBehavior: Clip.antiAlias,
                    color: Color(0xFF81D4FA),
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: ListTile(
                          title: new Center(
                            child: Text(
                              "Brilliance Dental Care",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            color: new Color(0x000000),
                            onPressed: () {
                              // Perform some action
                            },
                            child: new Icon(Icons.room),
                          ),
                          FlatButton(
                            color: new Color(0x000000),
                            onPressed: () {
                              // Perform some action
                            },
                            child: const Icon(Icons.phone),
                          ),
                        ],
                      ),
                    ])),
                Card(
                    margin: new EdgeInsets.symmetric(vertical: 20),
                    clipBehavior: Clip.antiAlias,
                    color: Color(0xFF81D4FA),
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: ListTile(
                          title: new Center(
                            child: Text(
                              "City Square Dental Care",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            color: new Color(0x000000),
                            onPressed: () {
                              // Perform some action
                            },
                            child: new Icon(Icons.room),
                          ),
                          FlatButton(
                            color: new Color(0x000000),
                            onPressed: () {
                              // Perform some action
                            },
                            child: const Icon(Icons.phone),
                          ),
                        ],
                      ),
                    ])),
                Card(
                    clipBehavior: Clip.antiAlias,
                    color: Color(0xFF81D4FA),
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: ListTile(
                          title: new Center(
                            child: Text(
                              "E Dental Care",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            color: new Color(0x000000),
                            onPressed: () {
                              // Perform some action
                            },
                            child: new Icon(Icons.room),
                          ),
                          FlatButton(
                            color: new Color(0x000000),
                            onPressed: () {
                              // Perform some action
                            },
                            child: const Icon(Icons.phone),
                          ),
                        ],
                      ),
                    ])),
              ],
            ),
          )
        ],
      ))),
    );
  }
}
