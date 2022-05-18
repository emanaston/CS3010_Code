import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasksadd/constants/assets.dart';
import 'package:tasksadd/utils/size_config.dart';
import 'package:tasksadd/views/pages/bottom%20nav%20bar/bottom_nav_bar.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Get.to(() => BottomNavBar(),
            transition: Transition.cupertinoDialog));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB2A4A3),
      body: SizedBox(
        height: SizeConfig.heightMultiplier * 100,
        width: SizeConfig.widthMultiplier * 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ABCDE",
              style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 6.4,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "Priority Management".toUpperCase(),
              style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 1.6,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
