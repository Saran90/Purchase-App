import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_app/main.dart';
import 'package:purchase_app/utils/colors.dart';

import '../../utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      // if((appStorage.getAccessToken()?.isNotEmpty)??false) {
      //   Get.offAndToNamed(addPurchaseBillRoute);
      // } else {
        Get.offAndToNamed(loginRoute);
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [appColorGradient1, appColorGradient2],
              begin: Alignment.topLeft,
              stops: [0.5, 1],
              end: Alignment.bottomRight
          ),
        ),
        child: Center(
          child: Text(
            'Purchase App',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
