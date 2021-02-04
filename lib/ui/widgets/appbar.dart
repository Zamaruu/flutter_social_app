import 'package:flutter/material.dart';
import 'package:flutter_social_app/ui/widgets/drawer.dart';

AppBar seriousFocusAppBar({String title}){
  return AppBar(
    title: Text(
      title
    ),
    backgroundColor: Colors.indigo[800],
  );
}