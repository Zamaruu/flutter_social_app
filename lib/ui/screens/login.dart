import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/services/authentication_service.dart';
import 'package:flutter_social_app/ui/screens/register.dart';
import 'package:flutter_social_app/ui/widgets/alerts.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
 
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
  TextEditingController _emailController;
  TextEditingController _passwordController;


  //Methoden
  @override
  void initState() {
    super.initState();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  _validateLoginData(){
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

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
    context.read<AuthenticationService>().signIn(email, password);
    //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "SeriousFocus",)), (route) => false);
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
      margin: EdgeInsets.all(_signInButtonMargin),
      width: MediaQuery.of(context).size.width * _signInButtonFactor,
      child: CupertinoButton(
        padding: EdgeInsets.all(_signInButtonPadding),
        child: _signinButtonContent("Anmelden", MdiIcons.account), 
        borderRadius: BorderRadius.circular(30),
        color: Colors.indigo[800],
        onPressed: _validateLoginData 
      ),
    );
  }

  Container _googleSignInButton(){
    return Container(
      margin: EdgeInsets.all(_signInButtonMargin),
      width: MediaQuery.of(context).size.width * _signInButtonFactor,
      child: CupertinoButton(
        padding: EdgeInsets.all(_signInButtonPadding),
        child: _signinButtonContent("Google Login", MdiIcons.google), 
        borderRadius: BorderRadius.circular(30),
        color: Colors.red[900],
        onPressed: (){
          context.read<AuthenticationService>().signInWithGoogle();
        } 
      ),
    );
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
              Container(
                width: MediaQuery.of(context).size.width * _widgetWidthFactor,
                child: Image.asset("images/branding/seriousfocus_brand_name.png"),
              ),
              _emailInputField(),
              _passwordInputField(),
              _loginButton(),
              Text("oder mit"),
              _googleSignInButton()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.accountPlus),
        tooltip: "Neu Registrieren",
        backgroundColor: Colors.indigo[800],
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RegisterRoute())
          );
        },
      ),
    );
  }
}