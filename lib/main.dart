import 'package:flutter/material.dart';
import 'package:defhacks/Screens/Landing/body.dart';
import 'package:defhacks/Screens/Landing/background.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      home: Body(),
    );
  }
}
