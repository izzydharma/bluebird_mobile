import 'package:flutter/material.dart';
import 'package:bluebird_mobile/menu.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         colorScheme: ColorScheme.fromSwatch(
       primarySwatch: Colors.lightBlue,
 ).copyWith(secondary: Colors.lightBlueAccent[400]),
      ),
      home: MyHomePage(),
    );
  }
}


