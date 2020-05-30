import 'package:drink_water/constants.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  String _animation = "200ml";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
          child: FlareActor(
            "assets/images/water_fill.flr",
            animation: _animation,
          ),
        ),
        RaisedButton(
          child: Text("Build"),
          onPressed: () {
            setState(() {
              _animation = "200ml";
            });
          },
        ),
        RaisedButton(
          child: Text("Build and Fade Out"),
          onPressed: () {
            setState(() {
              _animation = "400ml";
            });
          },
        ),
        ],
      )),
    );
  }
}
