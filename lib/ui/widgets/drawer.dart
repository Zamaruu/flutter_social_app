import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/model/current_user.dart';
import 'package:flutter_social_app/services/authentication_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SeriousFocusDrawer extends StatelessWidget {
  //Variablen
  TextStyle _inputStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    decorationColor: Colors.white,
    letterSpacing: 1
  );

  Row _signinButtonContent(String content, IconData icon){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          content,
          style: _inputStyle,
        ),
        SizedBox(width: 10,),
        Icon(
          icon,
        ) 
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo[800],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: CurrentUser.photoUrl != null? 
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(CurrentUser.photoUrl),                        
                    ):
                    CircleAvatar(
                      radius: 25,
                      child: Icon(MdiIcons.account)
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    CurrentUser.firstName + " " + CurrentUser.surName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    CurrentUser.email,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
        ] 
      ),
    );
  }
}