import 'dart:typed_data';

import 'package:drink_water/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  FlutterLocalNotificationsPlugin myLocalNotificationPlugin;

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings("ic_launcher");
    var initializationSettingsIos = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIos);
    myLocalNotificationPlugin = new FlutterLocalNotificationsPlugin();
    myLocalNotificationPlugin.initialize(
        initializationSettings); //,onSelectNotification: myOnSelectNotification);
  }

  // Future myOnSelectNotification(String payload) async {
  //   showDialog(
  //     context: context,
  //     builder: (_) {
  //       return new AlertDialog(
  //         title: Text("PayLoad"),
  //         content: Text("Payload : $payload"),
  //       );
  //     },
  //   );
  // }

  showNotification() async {
    var android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    var scheduledNotificationDateTime =
        new DateTime.now().add(Duration(seconds: 10));
    await myLocalNotificationPlugin.schedule(
      0,
      'It\'s time to drink water!',
      'Please finish drinking atleast 300mL of water!',
      scheduledNotificationDateTime,
      platform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Drink Water Reminder",
          style: myAppBarText,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: FlatButton(
                    onPressed: () {
                      //_showNotificationWithDefaultSound();
                      showNotification();
                    },
                    child: Text("Notify me"),
                    color: Color(0x505AA6EB),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: MyNavbar(),
    );
  }
}

class MyNavbar extends StatelessWidget {
  const MyNavbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.fillDrip),
          title: new Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.history),
          title: new Text("History"),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.screwdriver),
          title: new Text("Settings"),
        ),
      ],
    );
  }
}
