import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_social_app/ui/widgets/appbar.dart';
import 'package:flutter_social_app/ui/widgets/drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyNotesRoute extends StatefulWidget {
  @override
  _MyNotesRouteState createState() => _MyNotesRouteState();
}

class _MyNotesRouteState extends State<MyNotesRoute> {
  //Variablen
  int _titleLength = 0;
  int _contentLength = 0;

  TextEditingController _titleController;
  TextEditingController _contentController;
  TextStyle _inputStyle = TextStyle(
    color: Colors.black,
    fontSize: 18,
    decorationColor: Colors.white,
  );

  //Methoden
  addNewNote(){
    _titleLength = 0;
    _contentLength = 0;
    showGeneralDialog(    
      context: context,
      barrierDismissible: false,
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
        return StatefulBuilder(
          builder: (context, setState) {
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
                          maxLength: 20,
                          maxLengthEnforced: true,
                          onChanged: (String value){
                            setState(() {
                              _titleLength = value.length;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.centerRight,
                        child: Text(
                          _titleLength.toString() + " / 20",
                          style: TextStyle(
                            color: _titleLength <= 20? Colors.green: Colors.red
                          ),
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
                          onChanged: (String value){
                            setState(() {
                              _contentLength = value.length;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.centerRight,
                        child: Text(
                          _contentLength.toString() + " / 200",
                          style: TextStyle(
                            color: _contentLength <= 200? Colors.green: Colors.red
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      isDefaultAction: false,
                      child: Text("Verwerfen", style: TextStyle(color: Colors.red),),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text("Erstellen", style: TextStyle(color: Colors.green),),
                      onPressed: (){
                        if(_contentLength <= 200 && _titleLength <= 20){
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                )
              ),
            );
          }
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