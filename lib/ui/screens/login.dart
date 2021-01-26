import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  //Variablen
  double _widgetWidthFactor = 0.7;
  double _inputFiledMargin = 20;
  double _inputFiledPadding = 15;
  double _inputFieldTextSize = 20;
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
  TextEditingController _emailController;
  TextEditingController _passwordController;


  //Methoden
  @override
  void initState() {
    super.initState();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  _loginAlert({String title, String content}){
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

  _validateLoginData(){
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if(!_validateEmail(email)){
      print(_validateEmail(email));
      _loginAlert(title: "Fehler bei E-Mail", content: "Bitte überprüfen sie Ihre E-Mail Adresse auf Fehler!");
      return;
    }
    if(!_validatePassword(password)){
      print(_validateEmail(password));
      _loginAlert(title: "Fehler bei Passwort", content: "Bitte überprüfen sie Ihr Passwort!");
      return;
    }
    context.read<AuthenticationService>().signIn(email, password);
    //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "SeriousFocus",)), (route) => false);
  }

  bool _validateEmail(String email){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid;
  }

  bool _validatePassword(String password){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }

  Container _emailInputField(){
    return Container(
      margin: EdgeInsets.only(bottom: _inputFiledMargin, top: _inputFiledMargin),
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

  Container _loginButton(){
    return Container(
      child: CupertinoButton(
        child: Text(
          "Login",
          style: _inputStyle,
        ), 
        borderRadius: BorderRadius.circular(30),
        color: Colors.indigo[800],
        onPressed: _validateLoginData
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * _widgetWidthFactor,
              child: Image.asset("images/branding/seriousfocus_brand_name.png"),
            ),
            Text(
              "Login",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600
              ),
            ),
            _emailInputField(),
            _passwordInputField(),
            _loginButton()
          ],
        ),
      )
    );
  }
}