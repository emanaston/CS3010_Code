import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasksadd/constants/colors.dart';
import 'package:tasksadd/controllers/all_buttons_controller.dart';
import 'package:tasksadd/views/pages/sub%20tasks/sub_tasks.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/push_notifications.dart';
import '../../../../utils/size_config.dart';
import '../../../widgets/custom_appbar.dart';
import 'components/task_tile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //for push notifications
  late final FirebaseMessaging messaging;
  late int totalNotifications;
  PushNotificationModel? notificationInfo;
  void registerNotification() async {
    await Firebase.initializeApp();

    messaging = FirebaseMessaging.instance;
    NotificationSettings setting = await messaging.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);
    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted the permission");
      //main message
      FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
        PushNotificationModel notification = PushNotificationModel(
          title: msg.notification!.title,
          body: msg.notification!.body,
          dataTitle: msg.data["title"],
          datBody: msg.data["body"],
        );
        setState(() {
          totalNotifications++;
          notificationInfo = notification;
        });
        if (notification != null) {
          showSimpleNotification(Text(notificationInfo!.title!),
              leading: Container(),
              subtitle: Text(notificationInfo!.body!),
              background: kSecondaryColor,
              duration: const Duration(seconds: 3));
        }
      });
    } else {
      print("permission denied");
    }
  }

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
        ? print("User Logged in")
        : prefs.setString("uid", uuid.v1());
  }

  printUID() async {
    final cont = Get.put(AllButtonsController());
    final prefs = await SharedPreferences.getInstance();
    final String uid = prefs.getString("uid") ?? "";
    print(uid);
    cont.uid.value = uid;
  }

  @override
  void initState() {
    super.initState();

    tokenGenerater();
    tokenChecker();
    printUID();
     //push notifications
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
      PushNotificationModel notification = PushNotificationModel(
        title: msg.notification!.title,
        body: msg.notification!.body,
        dataTitle: msg.data["title"],
        datBody: msg.data["body"],
      );
      setState(() {
        totalNotifications++;
        notificationInfo = notification;
      });
    });
    registerNotification();
    totalNotifications = 0;
  }

  @override
  Widget build(BuildContext context) {
   
    List<String> myTaskAlphabets = [
      "A",
      "B",
      "C",
      "D",
      "E",
    ];
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(
              title: "My Tasks",
              isBackButton: false,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 5),
              color: const Color(0xFFebe4e2),
              child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        await Get.to(
                            () => SubTasksPage(
                                  mainTaskAlphabet: myTaskAlphabets[index],
                                ),
                            transition:
                                //  index.isEven
                                //     ?
                                Transition.rightToLeft
                            // :
                            // Transition.leftToRight
                            );
                      },
                      child: TaskTile(index: index))),
            )
          ],
        ),
      ),
    );
  }
}
