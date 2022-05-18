import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasksadd/constants/assets.dart';
import 'package:tasksadd/constants/colors.dart';
import 'package:tasksadd/utils/size_config.dart';
import 'package:tasksadd/views/pages/bottom%20nav%20bar/home/home.dart';
import 'package:tasksadd/views/pages/bottom%20nav%20bar/stats/stats.dart';
import 'package:tasksadd/views/widgets/first_time_login.dart';
import 'package:uuid/uuid.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../controllers/all_buttons_controller.dart';

// ignore: use_key_in_widget_constructors
class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  List<Widget> classes = [HomePage(), const StatsPage()];
  //FOR GETTING TEH UNIQUE USER
  var uuid = const Uuid();

  tokenGenerater() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("user", true);
  }

  tokenChecker() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isUserLoggedIn = prefs.getBool("user") ?? false;
    isUserLoggedIn
        ? print("Login user")
        : Timer(const Duration(seconds: 3), () {
            Get.back();
          });
    isUserLoggedIn
        ? print("User Logged in")
        : Get.dialog(const FirstTimeLoginDialog()).then((value) {
            prefs.setString("uid", uuid.v1()).then((value) {
              final cont = Get.put(AllButtonsController());
              final String uid = prefs.getString("uid") ?? "";
              cont.uid.value = uid;
              print(uid);
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    tokenChecker();

    return Scaffold(
      body: classes.elementAt(selectedIndex),
      bottomNavigationBar: BottomAppBar(
        color: kPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 49.6,
                color: kSecondaryColor,
                child: Center(
                  child: WebsafeSvg.asset(homeIcon,
                      color: selectedIndex == 0
                          ? const Color(0xFFf0d8cd)
                          : Colors.white,
                      height: SizeConfig.heightMultiplier * 4),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 49.6,
                color: kSecondaryColor,
                child: Center(
                  child: WebsafeSvg.asset(statIcon,
                      color: selectedIndex == 1
                          ? const Color(0xFFf0d8cd)
                          : Colors.white,
                      height: SizeConfig.heightMultiplier * 4),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
