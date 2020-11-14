import 'package:flutter/material.dart';

void main() {
  runApp(loginScreen());
}

class loginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: login(title: 'Flutter Demo Home Page'),
    );
  }
}

class login extends StatefulWidget {
  login({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  LoginScreen createState() => LoginScreen();
}

class LoginScreen extends State<login> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Form(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            new Container(
              margin: EdgeInsets.only(top: 50, bottom: 10),
              height: 175.0,
              width: 115.0,
              child: Image.asset('lib/Screens/assets/main_top.png'),
            )
          ],
        ),
      )),
    );
  }
}
