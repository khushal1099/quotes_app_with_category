import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quotes_app_with_category/helpers/db_helper.dart';
import 'package:quotes_app_with_category/view/homepage.dart';
import 'package:quotes_app_with_category/view/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper().initDb();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
