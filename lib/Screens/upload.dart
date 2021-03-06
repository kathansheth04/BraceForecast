import 'dart:convert';
import 'dart:io';
import 'package:defhacks/Screens/clinics.dart';
import 'package:defhacks/Screens/login.dart';
import 'package:defhacks/Screens/yesBraces.dart';
import 'package:defhacks/Screens/noBraces.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/files.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io' show Platform, stdout;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(uploadScreen());
}

class uploadScreen extends StatelessWidget {
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
      home: uploads(title: 'Flutter Demo Home Page'),
    );
  }
}

class uploads extends StatefulWidget {
  uploads({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<uploads> {
  String _path;

  Future<FirebaseUser> getUser() async {
    return await FirebaseAuth.instance.currentUser();
  }

  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  void _showPhotoLibrary(String email) async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _path = file.path;
    });
  }

  void predictionAction() async {
    final response = await http
        .get("http://10.0.0.65:5000", headers: {"Accept": "application/json"});
    var decoded = json.decode(response.body);
    if (decoded[0] == "1") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => yesBracesScreen()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => noBracesScreen()));
    }
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 150,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showPhotoLibrary(getUser().toString());
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library")),
                ListTile(
                    onTap: () => Navigator.of(context).pop(),
                    leading: Icon(Icons.cancel),
                    title: Text("Cancel")),
              ]));
        });
  }

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
            context, MaterialPageRoute(builder: (context) => uploadScreen()));
      } else {
        _selectedIndex = 1;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Clinics()));
      }
    });
  }

  void checkReport() {
    predictionAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Brace yourself'),
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
                icon: Icon(Icons.apps), title: Text('Upload Images')),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              title: Text('Clinics'),
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent,
          onTap: _onItemTapped,
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            _path == null
                ? Image.asset("images/place-holder.png")
                : Image.file(File(_path)),
            Container(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Do you need braces? Let\'s take a look!',
                  style: TextStyle(color: Colors.black, fontSize: 27),
                ),
              ),
            ),
            Card(
                margin:
                    EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
                clipBehavior: Clip.antiAlias,
                color: Colors.blue[100],
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: ListTile(
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
                        "1) Please take a picture of your teeth from the front including your bottom and top teeth using your camera \n 2) Click on the button below.",
                        style: TextStyle(
                            color: Colors.black, fontSize: 15, height: 1.3)),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 5),
                    width: 400,
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton.icon(
                        onPressed: () {
                          _showOptions(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        label: Text('Upload Image',
                            style:
                                TextStyle(color: Colors.black, fontSize: 17)),
                        icon: Icon(Icons.camera, color: Colors.black),
                        padding: const EdgeInsets.all(13.0),
                        splashColor: Colors.lightBlue[200],
                        color: Colors.lightBlue[100]),
                  ),
                ])),
            Card(
                margin:
                    EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                clipBehavior: Clip.antiAlias,
                color: Colors.blue[100],
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: ListTile(
                      title: new Center(
                        child: Text(
                          "How does this work?",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  new Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                      child: Text(
                          "You might be wondering what actually happens once you upload an image, here's how it works. By implementing a sequential neural network, our algorithm will analyze your uploaded image and compare it with sample data that we have trained our model on. This sample data is a database of pictures including cases of people who require braces as well as people who do not require braces. In addition, the images that previous users have uploaded to the app are added into the sample data so the model is continuously being trained and becoming more accurate. Using this data, we are able to compare similarities in tooth formation, thus classifying your teeth as either requiring braces or not. If you are already using treatment or braces, you can continuously be checking your progress within the app to see how close your teeth are to good formation!",
                          style: TextStyle(
                              color: Colors.black, fontSize: 15, height: 1.3))),
                  new Container(
                    margin: EdgeInsets.only(top: 5),
                    width: 400,
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton.icon(
                        onPressed: () {
                          this.predictionAction();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        label: Text('See Report',
                            style:
                                TextStyle(color: Colors.black, fontSize: 17)),
                        icon: Icon(Icons.file_copy, color: Colors.black),
                        padding: const EdgeInsets.all(13.0),
                        splashColor: Colors.lightBlue[200],
                        color: Colors.lightBlue[100]),
                  ),
                ])),
          ]),
        ));
  }
}
