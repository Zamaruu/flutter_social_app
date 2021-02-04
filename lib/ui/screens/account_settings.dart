import 'package:flutter/material.dart';
import 'package:flutter_social_app/ui/widgets/appbar.dart';
import 'package:flutter_social_app/ui/widgets/drawer.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: seriousFocusAppBar(title: "Kontoeinstellungen"),
      drawer: SeriousFocusDrawer(),
    );
  }
}