import 'package:animal_crossing_completion/pages/board_pages/first_board.dart';
import 'package:animal_crossing_completion/pages/board_pages/hemisphere.dart';
import 'package:animal_crossing_completion/pages/board_pages/name.dart';
import 'package:animal_crossing_completion/pages/board_pages/tutorial.dart';
import 'package:animal_crossing_completion/pages/more/balloon/balloon_screen.dart';
import 'package:animal_crossing_completion/pages/more/flowers/flowers_guide_screen.dart';
import 'package:animal_crossing_completion/pages/more/guide_screen.dart';
import 'package:animal_crossing_completion/pages/more/tools/tools_guide_screen.dart';
import 'package:flutter/material.dart';
import 'pages/todo_list_page/todo_list_page.dart';
import 'user.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('userName') != null)
    User.name = prefs.getString('userName');
  if (prefs.getBool('darkNightMode') != null) {
    User.darkKnightMode = prefs.getBool('darkNightMode');
  } else {
    prefs.setBool('darkNightMode', false);
    User.darkKnightMode = prefs.getBool('darkNightMode');
  }

  User.prefs = prefs;

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AC Completionist',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(
        'res/splash.flr',
        User.name != null ? new TodoListPage() : new FirstBoard(),
        startAnimation: 'splash',
      ),
      routes: {
        BoardTutorial.routeName: (BuildContext ctx) => BoardTutorial(),
        BoardHemisphere.routeName: (BuildContext ctx) => BoardHemisphere(),
        NameInput.routeName: (BuildContext ctx) => NameInput(),
        TodoListPage.routeName: (BuildContext ctx) => TodoListPage(),
        MoreGuides.routeName: (BuildContext ctx) => MoreGuides(),
        BalloonScreen.routeName: (BuildContext ctx) => BalloonScreen(),
        ToolsGuide.routeName: (BuildContext ctx) => ToolsGuide(),
        FlowerGuide.routeName: (BuildContext ctx) => FlowerGuide(),
      },
    );
  }
}
