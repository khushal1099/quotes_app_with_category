import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_with_category/view/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () {
        Get.to(
          HomePage(),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Image.asset("assets/qappicon.png"),
        ),
      ),
    );
  }
}
