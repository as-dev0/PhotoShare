import 'package:flutter/material.dart';
import 'models/postDetails.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../app.dart';
import 'package:flutter/services.dart';


class post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Post Picture'),),
        body: postForm()
        );
  }
}

class postForm extends StatefulWidget {
  @override 
  postFormState createState() => postFormState();
}

class postFormState extends State<postForm> {

  final formKey = GlobalKey<FormState>();
  final fields = postDetails();

  File? image;
  String? url;


  final ImagePicker picker = ImagePicker();
  Future? l; 

  void getImage() async {
    
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final geturl = await storageReference.getDownloadURL();
    url = geturl;
    setState(() {});
  }

  void finalize(){

    FirebaseFirestore.instance.collection('posts').add(
      {'imageURL': url, 'description': fields.description, 'title': fields.title, 
     'dateTime': fields.dateTime});
  }


  @override 
  Widget build (BuildContext context){

    if (image == null){
      getImage();
      return Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: 
            [Padding (padding: EdgeInsets.all(20), 
            child: Text("Uploading your picture"),), 
            
            CircularProgressIndicator(),],) );
      
    } else {
    return   Padding(
      padding: const EdgeInsets.all(10),
      child: Form(

        key: formKey,

        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            
            child:  Column(
            
              children: [

                Semantics(
                  image: true,
                  label: "This is the image you selected",
                  child: Image.file(File(image!.path)),
                ),

                Semantics(
                  label: "Enter title here",
                  onLongPressHint: "Enter title here",
                  child: 
                      TextFormField(
                        maxLength: 30,
                        decoration: InputDecoration(labelText: 'Title'),
                        onSaved: (value) {
                          fields.setTitle(value);
                        },
                        validator: (value) {
                          return value!.isEmpty ? "Please enter a title" : null;
                        },
                    ),
                ),

                Semantics(
                  label: "Enter description here",
                  onLongPressHint: "Enter description here",
                  child: 
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Description'),
                        onSaved: (value) {
                          fields.setDescription(value);
                        },
                        validator: (value) {
                          return value!.isEmpty ? "Please enter a description" : null;
                        },
                    ),
                ),

                Semantics(
                  label: "Tap to post",
                  button: true,
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: ElevatedButton(
                            onPressed: () async {

                              if (formKey.currentState!.validate()){
                            
                                formKey.currentState!.save();
                                fields.setDateTime(DateFormat('EEE, MMM d, y').format(DateTime.now()));
                                fields.setURL(url);
                                finalize();
                                Navigator.of(context).pop();
                                
                              }
                            }, 
                            child: Text('Post', style: TextStyle(fontSize: 25))
                          ),
                  ),
                )
              ]
        )
       )
      ),
      )
    );
    }
  }
}