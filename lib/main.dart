import 'package:city_hours/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Hours',
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.green[300],
      ),
      initialRoute: HomeScreen.ROUTE,
      routes: {
        HomeScreen.ROUTE: (context) => HomeScreen(),
      },
    );
  }
}
