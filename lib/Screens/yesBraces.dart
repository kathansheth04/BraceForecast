import 'dart:io';
import 'package:defhacks/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:defhacks/Screens/upload.dart';

class yesBracesScreen extends StatefulWidget {
  @override 
  yesBraces createState() => yesBraces(); 
}

class yesBraces extends State<yesBracesScreen> {

  String _path;
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
        'Index 1: Chart',
        style: optionStyle,
      ),
    ];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        _selectedIndex = 0;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => uploadScreen()));
      } else {
        _selectedIndex = 1;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => yesBracesScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Results'),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            title: Text('Main')),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            title: Text('Chart'),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
            _path == null ? Image.asset("images/place-holder.png") : 
            Image.file(File(_path)),
            Container(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Do you need braces? Let\'s take a look!',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
              ),
            Card(
                margin: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
                clipBehavior: Clip.antiAlias,
                color: Colors.blue[100],
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
                child: Column(children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: 
                        ListTile(
                          title: new Center(
                            child: Text(
                              "Image Uploading Instructions",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                        child: Text(
                          "Uploading Info: \n 1) Please take a picture of your teeh from the front including your bottom and top teeth using your camera \n 2) Click on the button labeled upload image",
                          style: 
                            TextStyle(color: Colors.black, fontSize: 15, height: 1.3)),
                          
                      )
                    ]
                  )
                ),
              new Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 400,
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton.icon(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0))),
                      label: Text('Upload Image',
                          style: TextStyle(color: Colors.black, fontSize: 17)),
                      icon: Icon(Icons.camera, color: Colors.black),
                      padding: const EdgeInsets.all(13.0),
                      splashColor: Colors.lightBlue[200],
                      color: Colors.lightBlue[100]),
                ),
              Card(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                clipBehavior: Clip.antiAlias,
                color: Colors.blue[100],
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
                child: Column(children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: 
                        ListTile(
                          title: new Center(
                            child: Text(
                              "Oral Hygiene Tips",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                        child: Text(
                          "Brushing: \n 1) Practice good technique \n 2) Brush your teeth for two minutes \n 3) Try to keep it separate from other toothbrushes in the same holder to prevent cross-contamination \n 4) Invest in a new toothbrush every three months",
                          style: 
                            TextStyle(color: Colors.black, fontSize: 15, height: 1.3))
                      ),
                      new Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                        child: Text(
                          "Flossing: \n 1) Don't rush \n 2) Don't snap the floss into your gums. When the floss reaches your gum line, curve it against one tooth, making a c shape. \n 3) Use the floss to gently rub the side of the tooth in an up-and-down motion \n 4)  If you find it hard to handle the floss, try using a water flosser.",
                          style: 
                            TextStyle(color: Colors.black, fontSize: 15, height: 1.3))
                          
                      )
                    ]
                  )
                ),
              ]
            ),
          )
        );

  }

}