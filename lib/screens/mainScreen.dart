import 'package:flutter/material.dart';
import 'displaySinglePostScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../app.dart';

class listPosts extends StatefulWidget{
  @override 
  listPostsState createState() => listPostsState();
}

class listPostsState extends State<listPosts>{

  @override 
  void initState(){
    super.initState();
  }

  @override 
  Widget build (BuildContext context){

      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.length > 0){

            return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data!.docs[index];
                      
                      return GestureDetector(
                        onTap: (() {goToSingleEntry(post['title'], 
                        post['description'], post['dateTime'], post['imageURL']);}  ) ,

                        child: Semantics(
                          child: ListTile(
                          leading: Text(post['title'], style: TextStyle(fontSize: 16)),
                          trailing: Text(post['dateTime'])),
                          
                          label: "A single post. Tap to view.",
                          ) 
                      );

                    },
                  );

          } else {
            return Center(
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Icon(Icons.photo_camera,size:60), 
                  Padding (padding: EdgeInsets.all(5),child: Text("No posts yet!"),)],
                  ) 
          );
          }
        },
      );
    
  }

  void goToSingleEntry(title, description, date, imageURL){
    setValues(title , description, date, imageURL);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => singlePostEntry()
    ));
  }

}
