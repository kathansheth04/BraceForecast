
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class uploadScreen extends StatefulWidget {
  @override 
  _HomePageState createState() => _HomePageState(); 
}

class _HomePageState extends State<uploadScreen> {

  String _path;

  void _showPhotoLibrary() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _path = file.path; 
    });

  }

  void _showOptions(BuildContext context) {
    
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          child: Column(children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text("Take a picture from camera")
            ), 
            ListTile(
              onTap: () {
                Navigator.pop(context); 
                _showPhotoLibrary(); 
              },
              leading: Icon(Icons.photo_library),
              title: Text("Choose from photo library")
            )
          ])
        );
      }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: Column(children: <Widget>[
          _path == null ? Image.asset("images/place-holder.png") : 
          Image.file(File(_path))
          ,
          FlatButton(
            child: Text("Take Picture", style: TextStyle(color: Colors.white)),
            color: Colors.green, 
            onPressed: () {
              _showOptions(context);
            },
          )
        ]),
      )
    );

  }

}