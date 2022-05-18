import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasksadd/controllers/all_buttons_controller.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/size_config.dart';

class TotalTaskWidget extends StatelessWidget {
  const TotalTaskWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cont = Get.put(AllButtonsController());
    return Container(
        height: SizeConfig.heightMultiplier * 7,
        width: SizeConfig.widthMultiplier * 55,
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3),
        decoration: const BoxDecoration(
            color: Color(0xFFC9BEBC), ),
        child: Row(children: [
          Text("Total Tasks Delegated:",
              style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 1.7,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
          const Spacer(),
          Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 1),
              color: Colors.white,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc(cont.uid.value)
                      .collection("TaskOptions")
                      .where("MainTask", isEqualTo: "D")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? Text("0",
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 2.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87))
                        : Obx(
                          ()=> Text(cont.dLength.value.toString(),
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87)),
                        );
                  }))
        ]));
  }
}
