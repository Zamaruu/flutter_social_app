import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startseite"),
      ),
      body: Center(
        child: CupertinoButton(
          child: Text(
            "Ausloggen",
            style: TextStyle(color: Colors.white),
          ), 
          borderRadius: BorderRadius.circular(30),
          color: Colors.indigo[800],
          onPressed: (){
            context.read<AuthenticationService>().signOut();
          }
        ),
      ),
    );
  }
}
