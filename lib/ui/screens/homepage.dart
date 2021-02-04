import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/ui/widgets/appbar.dart';
import 'package:flutter_social_app/ui/widgets/drawer.dart';

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
      appBar: seriousFocusAppBar(title: "Homepage"),
      drawer: SeriousFocusDrawer(),
      body: Center(

      ),
    );
  }
}
