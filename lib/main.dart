import 'package:flutter/material.dart';
import 'input_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'settings_page.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Drink Water Reminder",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF5AA6EB),
        accentColor: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      home: MyNavbar(),
    );
  }
}


class MyNavbar extends StatefulWidget {
  @override
  _MyNavbarState createState() => _MyNavbarState();
}

class _MyNavbarState extends State<MyNavbar> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    InputPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Drink Water Reminder",
          style: kAppBarText,
        ),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.fillDrip),
            title: new Text("Home"),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(FontAwesomeIcons.history),
          //   title: new Text("History"),
          // ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.screwdriver),
            title: new Text("Settings"),
          ),
        ],
      ),
    );
  }
}
