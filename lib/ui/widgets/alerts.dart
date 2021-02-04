import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

authAlert({String title, String content, BuildContext context}){
  showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: new Text(title),
      content: new Text(content),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text("Verstanden"),
          onPressed: (){Navigator.pop(context);},
        ),
      ],
    )
  ); 
}