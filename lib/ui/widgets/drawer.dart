import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/model/current_user.dart';
import 'package:flutter_social_app/services/authentication_service.dart';
import 'package:flutter_social_app/ui/screens/account_settings.dart';
import 'package:flutter_social_app/ui/screens/homepage.dart';
import 'package:flutter_social_app/ui/screens/mynotes.dart';
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
                Container( //User-Avatar
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
                Container( //User-Displayname
                  margin: EdgeInsets.only(top: 10),
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
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container( //User-Email
                        //margin: EdgeInsets.only(top: 10, bottom: 5),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          CurrentUser.email,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Theme(
                        data: ThemeData(
                          splashColor: Colors.white
                        ),
                        child: IconButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountSettings()));
                          },
                          icon: Icon(Icons.settings, color: Colors.white,),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ),
          ListTile(
            leading: Icon(MdiIcons.home, color: Colors.grey[800],),
            title: Text("Homepage"),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.notebook, color: Colors.grey[800],),
            title: Text("Meine Notizen"),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyNotesRoute()));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              height: 2,
              thickness: 1,
              color: Colors.grey[800],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoButton(
              child: _signinButtonContent("Ausloggen", Icons.logout), 
              borderRadius: BorderRadius.circular(30),
              color: Colors.red[800],
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