import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_social_app/ui/widgets/appbar.dart';
import 'package:flutter_social_app/ui/widgets/drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyNotesRoute extends StatefulWidget {
  @override
  _MyNotesRouteState createState() => _MyNotesRouteState();
}

class _MyNotesRouteState extends State<MyNotesRoute> {
  //Variablen
  TextEditingController _titleController;
  TextEditingController _contentController;
  TextStyle _inputStyle = TextStyle(
    color: Colors.black,
    fontSize: 18,
    decorationColor: Colors.white,
  );

  addNewNote(){
    showGeneralDialog(    
      context: context,
      barrierDismissible: false,
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: CupertinoAlertDialog(
              insetAnimationCurve: Curves.easeIn,
              insetAnimationDuration: Duration(milliseconds: 500),
              title: new Text("Neue Notiz"),
              content: Column(
                children: [
                  Container(
                    child: CupertinoTextField(
                      controller: _titleController,
                      style: _inputStyle,
                      placeholder: "Titel",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: CupertinoTextField(
                      controller: _titleController,
                      style: _inputStyle,
                      placeholder: "Text",
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: false,
                  child: Text("Verwerfen", style: TextStyle(color: Colors.red),),
                  onPressed: (){Navigator.pop(context);},
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Erstellen", style: TextStyle(color: Colors.green),),
                  onPressed: (){Navigator.pop(context);},
                ),
              ],
            )
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation1, animation2) {}
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: seriousFocusAppBar(title: "Meine Notizen"),
      drawer: SeriousFocusDrawer(),
      body: ListView(

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add),
        backgroundColor: Colors.indigo[800],
        onPressed: addNewNote,
      ),
    );
  }
}