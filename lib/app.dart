import 'package:flutter/material.dart';
import 'screens/addPostScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/mainScreen.dart';

class MyApp extends StatefulWidget{
  @override 
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Photo Share',
        home: ScaffoldController(),
        theme: ThemeData.dark(),
      );
  }
}

class ScaffoldController extends StatefulWidget{
  @override 
  ScaffoldControllerState createState() => ScaffoldControllerState();
}

class ScaffoldControllerState extends State<ScaffoldController> {

  @override
  Widget build(BuildContext context) {
    MyAppState? aState = context.findAncestorStateOfType<MyAppState>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Photo Share'),
          ),
        body: VerticalLayout() ,
        floatingActionButton: SemanticsFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
  }
}

class SemanticsFAB extends StatelessWidget{
  @override 
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: "Tap to add post",
      child: FloatingActionButton(
          onPressed:() {goToAddEntry(context);},
          child: const Icon(Icons.photo_camera),
          ),
    );
  }
}

class VerticalLayout extends StatelessWidget{

  @override 
  Widget build(BuildContext context) {
    return listPosts();
  }
}

void goToAddEntry(BuildContext context){
	Navigator.of(context).push(MaterialPageRoute(builder: (context) => post()));
}