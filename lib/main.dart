import 'package:flutter/material.dart';
import 'input_page.dart';

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
            color: Colors.white,
          ),
        ),
      ),
      home: InputPage(),
    );
  }
}
