import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

String singleTitle ="";
String singleDescription = "";
String singleDate = "";
String singleImageURL = "";

void setValues (title, description, date, imageURL){
  singleTitle = title;
  singleDescription = description;
  singleDate = date;
  singleImageURL = imageURL;
}

class singlePostEntry extends StatefulWidget{
  @override
  singlePostEntryState createState() => singlePostEntryState();
}

class singlePostEntryState extends State<singlePostEntry> {

  final storageRef = FirebaseStorage.instance.ref();
  final  httpsReference = FirebaseStorage.instance.refFromURL(singleImageURL);
  var maxSize = 1024 * 1024 * 2;
  Uint8List? data;

  void downloadImage() async{
    data = await httpsReference.getData(maxSize);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    if (data == null){
      downloadImage();
      return Scaffold(
          appBar: AppBar(title: Text(singleTitle)),
          body: Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                      Padding (padding: EdgeInsets.all(20), 
                        child: Text("Downloading your post"),),

                      CircularProgressIndicator(),
                      ],) )
          );
    }
    else {
    return Scaffold(
        appBar: AppBar(title: Text(singleTitle)),
        body: Center(child: SingleChildScrollView(child: 
        
        Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Padding( padding: EdgeInsets.all(20), 
            child: Text(singleDate, style: TextStyle(fontSize: 15)),),

            Image.memory(data!),
            
            Padding(padding: EdgeInsets.all(25), 
            child: Text("${singleDescription}", 
             style: TextStyle(fontSize: 25)),),

          ])
        
        ,))
        );
      }
  }
}
