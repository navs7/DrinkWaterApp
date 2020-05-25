import 'package:drink_water/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  FlutterLocalNotificationsPlugin myLocalNotificationPlugin;
  TextEditingController valueInputController = new TextEditingController();

  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  int waterConsumed = 0;

  @override
  void initState() {
    super.initState();
    //NOTIFICATION OPERATIONS
    var initAndroid = new AndroidInitializationSettings("ic_launcher");
    var initIos = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(initAndroid, initIos);
    myLocalNotificationPlugin = new FlutterLocalNotificationsPlugin();
    myLocalNotificationPlugin.initialize(
        initSettings); //,onSelectNotification: myOnSelectNotification);
    //FILE OPERATIONS
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
            () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
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

  @override
  void dispose() {
    valueInputController.dispose();
    super.dispose();
  }

  void createFile(
      Map<String, dynamic> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, dynamic value) {
    print("Writing to file!");
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(content, dir, fileName);
    }
    //this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    //print("file content" + fileContent.toString());
  }

  void readFile() {
    print("Reading from file!");
    int total = 0;
    if (fileExists) {
      this.setState(
          () => fileContent = json.decode(jsonFile.readAsStringSync()));
      print("file content" + fileContent.toString());
      fileContent.forEach((key, value) {
        total = total + int.parse(value);
      });
      waterConsumed = total;
      print(waterConsumed);
    } else {
      print("File does not exist!");
    }
  }

  showNotification() async {
    var now = DateTime.now();
    if (DateTime(now.hour).isAfter(DateTime(7)) &&
        DateTime(now.hour).isBefore(DateTime(23))) {
      var android = AndroidNotificationDetails(
          'channel id', 'channel name', 'channel description');
      var iOS = IOSNotificationDetails();
      var platform = NotificationDetails(android, iOS);
      // var scheduledNotificationDateTime =
      //     new DateTime.now().add(Duration(seconds: 10));
      RepeatInterval myRepeatInterval = RepeatInterval.Hourly;
      await myLocalNotificationPlugin.periodicallyShow(
        0,
        'It\'s time to drink water!',
        'Please finish drinking atleast 200mL of water!',
        myRepeatInterval,
        platform,
      );
    }
    // .schedule(
    //   0,
    //   'It\'s time to drink water!',
    //   'Please finish drinking atleast 300mL of water!',
    //   scheduledNotificationDateTime,
    //   platform,
    // );
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
          Text(
            waterConsumed.toString(),
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50.0,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: new EdgeInsets.only(top: 10.0),
          ),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: FlatButton(
                    onPressed: () {
                      writeToFile(
                          DateTime.now().toString(), "200");
                      readFile();
                    },
                    child: Text("200 ml water"),
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
