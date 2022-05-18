import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasksadd/constants/colors.dart';
import 'package:tasksadd/controllers/all_buttons_controller.dart';
import 'package:tasksadd/views/widgets/custom_appbar.dart';

import '../../../utils/size_config.dart';

class AddDescriptionPage extends StatelessWidget {
  const AddDescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final descriptionCont = Get.put(AllButtonsController());
    TextEditingController desCont =
        TextEditingController(text: descriptionCont.taskDescription.value);
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                title: "Notes",
                isBackButton: true,
                donePress: () {
                  descriptionCont.taskDescription.value = desCont.text;
                  Get.back();
                },
              ),
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
                    SizedBox(height: SizeConfig.heightMultiplier * 3),
                    Text(
                      "Task 1",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.textMultiplier * 2.5),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    const Divider(
                        height: 1, thickness: 2, color: defaultTileColor),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4),
                      child: TextField(
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.6,
                            fontWeight: FontWeight.w500),
                        controller: desCont,
                        maxLines: 32,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Description Here...."),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
