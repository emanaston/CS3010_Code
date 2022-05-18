import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasksadd/constants/assets.dart';
import 'package:tasksadd/constants/colors.dart';
import 'package:tasksadd/utils/size_config.dart';
import 'package:tasksadd/views/pages/add%20task/add_task.dart';
import 'package:tasksadd/views/widgets/custom_appbar.dart';
import 'package:uuid/uuid.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../controllers/all_buttons_controller.dart';
import '../../../services/database.dart';
import 'components/sub_task_tile.dart';

class SubTasksPage extends StatefulWidget {
  const SubTasksPage({Key? key, required this.mainTaskAlphabet})
      : super(key: key);
  final String mainTaskAlphabet;

  @override
  State<SubTasksPage> createState() => _SubTasksPageState();
}

class _SubTasksPageState extends State<SubTasksPage> {
  final cont = Get.put(AllButtonsController());
  TextEditingController enterName = TextEditingController();
  @override
  void dispose() {
    cont.isTaskIsAdding.value = false;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(title: "My Tasks", isBackButton: true),
            SizedBox(height: SizeConfig.heightMultiplier * 4),
            Container(
              height: SizeConfig.heightMultiplier * 80,
              width: SizeConfig.widthMultiplier * 90,
              decoration: BoxDecoration(
                  color: kLightGrey, borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 8),
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(cont.uid.value)
                          .collection("TaskOptions")
                          .where("MainTask", isEqualTo: widget.mainTaskAlphabet)
                          .orderBy("Date")
                          .snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const SizedBox()
                          :  Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.heightMultiplier * 3),
                                child: Text(
                                  "${widget.mainTaskAlphabet} Tasks",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      fontSize:
                                          SizeConfig.textMultiplier * 2.5),
                                ),
                              );
                      }),
                  SubTaskTile(
                    mainTaskAlphabet: widget.mainTaskAlphabet,
                  ),
                  //FOR ADDING INSTANT NAME
                  Obx(
                    () => cont.isTaskIsAdding.value
                        ? Container(
                            height: SizeConfig.heightMultiplier * 7,
                            width: SizeConfig.widthMultiplier * 100,
                            decoration: BoxDecoration(
                                color: defaultTileColor,
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.heightMultiplier * 1),
                            padding: EdgeInsets.only(
                                left: SizeConfig.widthMultiplier * 2),
                            child: Row(children: [
                              CircleAvatar(
                                radius: SizeConfig.widthMultiplier * 3,
                                backgroundColor: const Color(0xFF96A6FF),
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 2,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 45,
                                child: TextField(
                                  controller: enterName,
                                  autofocus: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: SizeConfig.textMultiplier * 2),
                                  decoration: const InputDecoration(
                                      hintText: "Enter name",
                                      border: InputBorder.none),
                                ),
                              ),
                              const Spacer(),
                              //ADD BUTTON
                              IconButton(
                                  onPressed: () {
                                    if (enterName.text.isNotEmpty) {
                                      DataBase()
                                          .addNotes(
                                              enterName.text,
                                              widget.mainTaskAlphabet,
                                              widget.mainTaskAlphabet == "A"
                                                  ? "A1"
                                                  : "",
                                              2,
                                              "Tap to add description to this task...",
                                              [],
                                              0,
                                              cont.uid.value,
                                              [])
                                          .then((value) {
                                        cont.timeList.value = [];
                                        cont.isTaskIsAdding.value = false;
                                        enterName.clear();
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Please enter name")));
                                    }
                                  },
                                  icon: const Icon(Icons.done,
                                      color: Colors.white)),
                              //GO BACK BUTTON
                              IconButton(
                                  onPressed: () {
                                    cont.isTaskIsAdding.value = false;
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Colors.white))
                            ]))
                        : const SizedBox(),
                  ),
                  const Spacer(),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(cont.uid.value)
                          .collection("TaskOptions")
                          .where("MainTask", isEqualTo: widget.mainTaskAlphabet)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return InkWell(
                          onTap: () {
                            cont.isTaskIsAdding.value = true;
                          },
                          child: Container(
                            height: SizeConfig.heightMultiplier * 10,
                            width: SizeConfig.widthMultiplier * 20,
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.heightMultiplier * 2),
                            decoration: const BoxDecoration(
                                color: kSecondaryColor, shape: BoxShape.circle),
                            child: WebsafeSvg.asset(addIcon,
                                color: kLightGrey,
                                height: SizeConfig.heightMultiplier * 9),
                          ),
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
