import 'package:flutter/material.dart';
import 'package:money_tracker/pages/home.dart';
import 'package:money_tracker/themes/colours.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('Money');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Money Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primaryMaterialColor,
        ),
        home: const HomePage());
  }
}
