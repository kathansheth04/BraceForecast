import 'package:defhacks/Screens/upload.dart';
import 'package:flutter/material.dart';
import 'package:defhacks/Screens/Landing/body.dart';
import 'package:defhacks/Screens/Landing/background.dart';
import 'package:defhacks/Screens/login.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Title',
      home: Body(),
    );
  }
}
