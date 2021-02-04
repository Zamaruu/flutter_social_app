import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/main.dart';
import 'package:flutter_social_app/services/authentication_service.dart';
import 'package:flutter_social_app/ui/screens/homepage.dart';
import 'package:flutter_social_app/ui/widgets/alerts.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RegisterRoute extends StatefulWidget {
  @override
  _RegisterRouteState createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  //Variablen
  double _widgetWidthFactor = 0.7;
  double _inputFiledMargin = 20;
  double _inputFiledPadding = 15;
  double _inputFieldTextSize = 20;
  double _signInButtonFactor = 0.6;
  double _signInButtonPadding = 10;
  double _signInButtonMargin = 10;
  bool _hidePassword = true;
  int _minPasswordLength = 6;

  Color _inputFieldColor = Colors.white;
  TextStyle _inputStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    decorationColor: Colors.white,
    letterSpacing: 1
  );
  BoxDecoration _inputDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: Colors.white,
    gradient: LinearGradient(colors: [Colors.indigo[800], Colors.cyanAccent]),
  );
  TextEditingController _firstNameController;
  TextEditingController _surNameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  //Methoden
  @override
  void initState() { 
    super.initState();
    _firstNameController = new TextEditingController();
    _surNameController = new TextEditingController();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  Container _firstnameInputField(){
    return Container(
      margin: EdgeInsets.only(bottom: _inputFiledMargin, top: _inputFiledMargin),
      width: MediaQuery.of(context).size.width * _widgetWidthFactor,
      child: CupertinoTextField(
        autofocus: false,
        clearButtonMode: OverlayVisibilityMode.editing,
        controller: _firstNameController,
        placeholder: "Vorname",
        keyboardType: TextInputType.text,
        prefix: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(Icons.text_fields, color: _inputFieldColor,),
        ),
        padding: EdgeInsets.all(_inputFiledPadding),
        style: _inputStyle,
        placeholderStyle: _inputStyle,
        decoration: _inputDecoration
      ),
    );
  }

  Container _surnameInputField(){
    return Container(
      margin: EdgeInsets.only(bottom: _inputFiledMargin),
      width: MediaQuery.of(context).size.width * _widgetWidthFactor,
      child: CupertinoTextField(
        autofocus: false,
        clearButtonMode: OverlayVisibilityMode.editing,
        controller: _surNameController,
        placeholder: "Nachname",
        keyboardType: TextInputType.text,
        prefix: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(Icons.text_fields, color: _inputFieldColor,),
        ),
        padding: EdgeInsets.all(_inputFiledPadding),
        style: _inputStyle,
        placeholderStyle: _inputStyle,
        decoration: _inputDecoration
      ),
    );
  }

  Container _emailInputField(){
    return Container(
      margin: EdgeInsets.only(bottom: _inputFiledMargin),
      width: MediaQuery.of(context).size.width * _widgetWidthFactor,
      child: CupertinoTextField(
        autofocus: false,
        clearButtonMode: OverlayVisibilityMode.editing,
        controller: _emailController,
        placeholder: "E-Mail",
        keyboardType: TextInputType.emailAddress,
        prefix: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(Icons.mail, color: _inputFieldColor,),
        ),
        padding: EdgeInsets.all(_inputFiledPadding),
        style: _inputStyle,
        placeholderStyle: _inputStyle,
        decoration: _inputDecoration
      ),
    );
  }

  Container _passwordInputField(){
    return Container(
      margin: EdgeInsets.only(bottom: _inputFiledMargin),
      width: MediaQuery.of(context).size.width * _widgetWidthFactor,
      child: CupertinoTextField(
        autofocus: false,
        clearButtonMode: OverlayVisibilityMode.editing,
        controller: _passwordController,
        placeholder: "Passwort",
        obscureText: _hidePassword,
        prefix: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(Icons.lock, color: _inputFieldColor,),
        ),
        suffix: IconButton(
          onPressed: () {setState(() {_hidePassword = !_hidePassword;});},
          color: _inputFieldColor,
          icon: Icon(_hidePassword? Icons.visibility_off: Icons.visibility),
        ),
        padding: EdgeInsets.all(_inputFiledPadding),
        style: _inputStyle,
        placeholderStyle: _inputStyle,
        decoration: _inputDecoration
      ),
    );
  }

  _validateRegisterData(){
    String firstName = _firstNameController.text.trim();
    String surName = _surNameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if(!validateNames(firstName)){
      print(validateNames(firstName));
      authAlert(title: "Fehler bei Vornamen", content: "Ihr Vorname ist zu kurz oder zu lang!", context: context);
      return;
    }
    if(!validateNames(surName)){
      print(validateNames(firstName));
      authAlert(title: "Fehler bei Nachnamen", content: "Ihr Nachname ist zu kurz oder zu lang!", context: context);
      return;
    }
    if(!validateEmail(email)){
      print(validateEmail(email));
      authAlert(title: "Fehler bei E-Mail", content: "Bitte überprüfen sie Ihre E-Mail Adresse auf Fehler!", context: context);
      return;
    }
    if(!validatePassword(password)){
      print(validateEmail(password));
      authAlert(title: "Fehler bei Passwort", content: "Bitte überprüfen sie Ihr Passwort!", context: context);
      return;
    }
    context.read<AuthenticationService>().signUp(firstName, surName, email, password);
    Navigator.pop(context);
    //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

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

  Container _registerButton(){
    return Container(
      margin: EdgeInsets.all(_signInButtonMargin),
      width: MediaQuery.of(context).size.width * _signInButtonFactor,
      child: CupertinoButton(
        padding: EdgeInsets.all(_signInButtonPadding),
        child: _signinButtonContent("Registrieren", MdiIcons.accountPlus), 
        borderRadius: BorderRadius.circular(30),
        color: Colors.indigo[800],
        onPressed: _validateRegisterData
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          //width: MediaQuery.of(context).size.width * _widgetWidthFactor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Registrieren Sie ein neues Konto",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              ),
              _firstnameInputField(),
              _surnameInputField(),
              _emailInputField(),
              _passwordInputField(),
              _registerButton(),
            ],
          ),
        ),
      ),
    );
  }
}