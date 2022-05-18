import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasksadd/controllers/all_buttons_controller.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/size_config.dart';
import '../../add task/add_task.dart';

class SubTaskTile extends StatelessWidget {
  const SubTaskTile({
    Key? key,
    required this.mainTaskAlphabet,
  }) : super(key: key);
  final String mainTaskAlphabet;
  @override
  Widget build(BuildContext context) {
final DateFormat formatter = DateFormat('yyyy-MM-dd');

    List<Color> colors = const [
      Color(0xFFFF7987),
      Color(0xFF8CE4A0),
      Color(0xFF96A6FF),
      Color(0xFFFFFA79),
      Color(0xFFEBA2DF),
      Color(0xFFFFC896),
      Color(0xFFE4C68C),
      Color(0xFFFBB7C7)
    ];
    final cont = Get.put(AllButtonsController());
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(cont.uid.value)
            .collection("TaskOptions")
            .where("MainTask", isEqualTo: mainTaskAlphabet)
            .orderBy("Date")
            .snapshots(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? SizedBox(
                  height: SizeConfig.heightMultiplier * 60,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  ),
                )
              : snapshot.data!.docs.isNotEmpty
                  ? SizedBox(
                      height: SizeConfig.heightMultiplier * 49,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.all(0),
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            final snap = snapshot.data!.docs[index];
                            return formatter.format(DateTime.parse(snap.get("Date")))==formatter.format(DateTime.now())? Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                        () => AddTaskPage(
                                              isAddTask: false,
                                              mainTaskAlphabet:
                                                  mainTaskAlphabet,
                                              taskID: snap.id,
                                              weighting:
                                                  snap.get("Weighting")??"",
                                            ),
                                        transition: Transition.rightToLeft);
                                  },
                                  child: Container(
                                    height: SizeConfig.heightMultiplier * 7,
                                    width: SizeConfig.widthMultiplier * 100,
                                    decoration: BoxDecoration(
                                        color: defaultTileColor,
                                        border: Border.all(
                                            color: Colors.white, width: 1)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 2),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius:
                                              SizeConfig.widthMultiplier * 3,
                                          backgroundColor:
                                              colors[snap.get("ColorIndex")],
                                        ),
                                        SizedBox(
                                          width: SizeConfig.widthMultiplier * 2,
                                        ),
                                        mainTaskAlphabet == "D"
                                            ? SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        60,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: SizeConfig
                                                              .widthMultiplier *
                                                          20,
                                                      child: Text(
                                                        snap.get("Title"),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                            fontSize: SizeConfig
                                                                    .textMultiplier *
                                                                2),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 2,
                                                          width: 8,
                                                          color: Colors.white,
                                                          margin: EdgeInsets.only(
                                                              right: SizeConfig
                                                                      .widthMultiplier *
                                                                  2),
                                                        ),
                                                        SizedBox(
                                                          width: SizeConfig
                                                                  .widthMultiplier *
                                                              20,
                                                          child: Text(
                                                            snap.get("DelegateTo") ==
                                                                    ""
                                                                ? "Nobody..."
                                                                : snap.get(
                                                                    "DelegateTo"),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: SizeConfig
                                                                        .textMultiplier *
                                                                    2),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        30,
                                                child: Text(
                                                  snap.get("Title"),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                      fontSize: SizeConfig
                                                              .textMultiplier *
                                                          2),
                                                ),
                                              ),
                                        //FOR D TASK
                                        const Spacer(),
                                        mainTaskAlphabet == "D" ||
                                                mainTaskAlphabet == "E"
                                            ? const SizedBox()
                                            : Icon(Icons.done,
                                                size:
                                                    snap.get("Progress") == 100
                                                        ? 17
                                                        : 0,
                                                color: Colors.white),
                                        mainTaskAlphabet == "D" ||
                                                mainTaskAlphabet == "E"
                                            ? const SizedBox()
                                            : SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        2,
                                              ),
                                        mainTaskAlphabet == "D" ||
                                                mainTaskAlphabet == "E"
                                            ? const SizedBox()
                                            : Container(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    2,
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        15,
                                                color: kLightGrey,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          2,
                                                      width: snap.get(
                                                                  "Progress") ==
                                                              100
                                                          ? SizeConfig
                                                                  .widthMultiplier *
                                                              15
                                                          : snap.get(
                                                                  "Progress") /
                                                              2,
                                                      color: const Color(
                                                          0xFF7EFF9B),
                                                    ),
                                                  ],
                                                )),
                                        ///////
                                        //for A TASK
                                        mainTaskAlphabet == "A"
                                            ? SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        2)
                                            : const SizedBox(),
                                        mainTaskAlphabet == "A"
                                            ? CircleAvatar(
                                                radius:
                                                    SizeConfig.widthMultiplier *
                                                        4,
                                                backgroundColor: kPrimaryColor,
                                                child: Text(
                                                  snap.get("Weighting")??"",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .textMultiplier *
                                                          1.8,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black87),
                                                ),
                                              )
                                            : const SizedBox(),
                                        /////
                                        SizedBox(
                                          width: SizeConfig.widthMultiplier * 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ) : const SizedBox();
                          }),
                    )
                  : const SizedBox();
        });
  }
}
