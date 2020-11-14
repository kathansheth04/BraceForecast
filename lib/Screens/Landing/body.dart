import 'package:flutter/material.dart';
import 'package:defhacks/Screens/Landing/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.5),
            SizedBox(height: size.height * 0.05),
            new Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(10.0),
                width: size.width * 0.85, 
                child: RaisedButton.icon(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    label: Text('Log in',
                        style: TextStyle(color: Colors.black, fontSize: 17)),
                    icon:
                        Icon(Icons.supervised_user_circle, color: Colors.black),
                    padding: const EdgeInsets.all(13.0),
                    splashColor: Colors.lightBlue[100],
                    color: Colors.lightBlue[200]),
              ),
            new Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(10.0),
                width: size.width * 0.85, 
                child: RaisedButton.icon(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    label: Text('Register',
                        style: TextStyle(color: Colors.black, fontSize: 17)),
                    icon:
                        Icon(Icons.supervised_user_circle, color: Colors.black),
                    padding: const EdgeInsets.all(13.0),
                    splashColor: Colors.lightBlue[200],
                    color: Colors.lightBlue[100]),
              ),
          ],
        ),
      ),
    );
  }
}