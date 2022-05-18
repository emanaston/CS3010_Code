import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasksadd/constants/colors.dart';
import 'package:tasksadd/controllers/all_buttons_controller.dart';
import 'package:tasksadd/services/database.dart';
import 'package:tasksadd/utils/size_config.dart';
import 'package:tasksadd/views/pages/add%20description/add_description.dart';
import 'package:tasksadd/views/pages/add%20task/components/delegate_bottom_sheet.dart';
import 'package:tasksadd/views/pages/add%20timer/add_timer.dart';
import 'package:tasksadd/views/widgets/custom_appbar.dart';
import 'components/heading_container.dart';
import 'components/select_color.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage(
      {Key? key,
      required this.mainTaskAlphabet,
      required this.isAddTask,
      this.taskID,
      this.weighting})
      : super(key: key);
  final String mainTaskAlphabet;
  final bool isAddTask;
  final String? taskID;
  final String? weighting;

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final sliderCont = Get.put(AllButtonsController());
  TextEditingController titleCont = TextEditingController();
  @override
  void initState() {
    //getting all values for that task
    widget.isAddTask
        ? sliderCont.taskDescription.value =
            "Tap to add a description to this task..."
        : FirebaseFirestore.instance
            .collection("Users")
            .doc(sliderCont.uid.value)
            .collection("TaskOptions")
            .doc(widget.taskID)
            .get()
            .then((value) {
            titleCont.text = value["Title"];
            sliderCont.selectedColorIndex.value = value["ColorIndex"];
            sliderCont.sliderVal.value = value["Progress"];
            sliderCont.taskDescription.value = value["Description"];
            sliderCont.timeList.value = value["Time"];
            sliderCont.delegateTo.value = value["DelegateTo"];
            sliderCont.timeInMiliseconds.value=value["MilisecondsTime"];
          });

    super.initState();
  }

  @override
  void dispose() {
    sliderCont.timeList.value = [];
    sliderCont.timeInMiliseconds.value = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kLightGrey,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                  title: "Task Options",
                  isBackButton: true,
                  donePress: () {
                    //adding data into firebase
                    if (titleCont.text.isNotEmpty &&
                        sliderCont.taskDescription.value.isNotEmpty) {
                      DataBase()
                          .updateNotes(
                              widget.taskID ?? "",
                              titleCont.text,
                              widget.mainTaskAlphabet,
                              widget.mainTaskAlphabet == "A" ? "A1" : "",
                              sliderCont.selectedColorIndex.value,
                              sliderCont.taskDescription.value,
                              sliderCont.timeList,
                              sliderCont.sliderVal.value,
                              sliderCont.uid.value,
                              sliderCont.timeInMiliseconds)
                          .then((value) {
                        sliderCont.timeList.value = [];
                        sliderCont.timeInMiliseconds.value = [];
                      });
                      Get.back();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please fill all the data")));
                    }
                  }),
              Center(
                  child: SizedBox(
                width: SizeConfig.widthMultiplier * 50,
                child: TextField(
                  controller: titleCont,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black87),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Task Name here",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.black45),
                  ),
                ),
              )),
              const HeadingContainer(
                text: "Priority",
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.heightMultiplier * 2,
                    left: SizeConfig.widthMultiplier * 5),
                child: Text(
                  widget.mainTaskAlphabet,
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
              //FOR A TASK
              widget.mainTaskAlphabet == "A"
                  ? const HeadingContainer(
                      text: "Weighting",
                    )
                  : const SizedBox(),
              widget.mainTaskAlphabet == "A"
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier * 2,
                          left: SizeConfig.widthMultiplier * 5),
                      child: CircleAvatar(
                        backgroundColor: kPrimaryColor,
                        child: Text(
                          widget.weighting ?? "",
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 2.8,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                    )
                  : const SizedBox(),
              ///////
              const HeadingContainer(
                text: "Colour",
              ),
              const SelectColor(),
              const HeadingContainer(
                text: "TaskOptions",
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const AddDescriptionPage(),
                      transition: Transition.leftToRight);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.heightMultiplier * 3,
                      bottom: SizeConfig.heightMultiplier * 1,
                      left: SizeConfig.widthMultiplier * 5),
                  child: SizedBox(
                    width: SizeConfig.widthMultiplier * 60,
                    child: Obx(
                      () => Text(
                        sliderCont.taskDescription.value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.textMultiplier * 1.6,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
              widget.mainTaskAlphabet == "D" || widget.mainTaskAlphabet == "E"
                  ? const SizedBox()
                  : const HeadingContainer(
                      text: "Progress",
                    ),
              //for D TASK
              widget.mainTaskAlphabet == "D" || widget.mainTaskAlphabet == "E"
                  ? const SizedBox()
                  : SizedBox(height: SizeConfig.heightMultiplier * 1),
              widget.mainTaskAlphabet == "D" || widget.mainTaskAlphabet == "E"
                  ? const SizedBox()
                  : Obx(
                      () => Center(
                        child: Text(
                          "${sliderCont.sliderVal.value.toString().split(".")[0]} %",
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 3,
                              fontWeight: FontWeight.w600,
                              color: Colors.green),
                        ),
                      ),
                    ),
              widget.mainTaskAlphabet == "D" || widget.mainTaskAlphabet == "E"
                  ? const SizedBox()
                  : Obx(
                      () => SizedBox(
                        height: SizeConfig.heightMultiplier * 4,
                        child: Slider(
                            min: 0,
                            max: 100,
                            thumbColor: Colors.white,
                            inactiveColor: Colors.black,
                            activeColor: Colors.green,
                            value: sliderCont.sliderVal.value,
                            onChanged: (val) {
                              sliderCont.sliderVal.value = val;
                            }),
                      ),
                    ),
              widget.mainTaskAlphabet == "D" || widget.mainTaskAlphabet == "E"
                  ? const SizedBox()
                  : SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
              HeadingContainer(
                text: widget.mainTaskAlphabet == "D"
                    ? "Delegated To"
                    : "Time Task",
              ),
              //////
              InkWell(
                onTap: () {
                  widget.mainTaskAlphabet == "D"
                      ? Get.dialog(DelegateToDialog(
                          taskID: widget.taskID ?? "",
                        ))
                      : Get.to(() => const AddTimerPage(),
                          transition: Transition.rightToLeft);
                },
                child: Obx(
                  () => Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.heightMultiplier * 3,
                        bottom: SizeConfig.heightMultiplier * 1,
                        left: SizeConfig.widthMultiplier * 5),
                    child: Text(
                      widget.mainTaskAlphabet == "D"
                          ? sliderCont.delegateTo.value == ""
                              ? "Tap to delegate this task"
                              : sliderCont.delegateTo.value
                          : sliderCont.timeList.value.isEmpty
                              ? "Tap to time this task..."
                              : "Tap to add more time to this task",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.textMultiplier * 1.6,
                          color: Colors.black87),
                    ),
                  ),
                ),
              ),

              Obx(() {
                sliderCont.timeList.value;

                return SizedBox(
                  child: sliderCont.timeList.value.isEmpty
                      ? const SizedBox()
                      : Wrap(
                          children: [
                            ...List.generate(
                              sliderCont.timeList.value.length,
                              (index) => Container(
                                height: SizeConfig.heightMultiplier * 6,
                                width: SizeConfig.widthMultiplier * 35,
                                color: const Color(0xFF837D7C),
                                margin: EdgeInsets.only(
                                    top: SizeConfig.heightMultiplier * 2,
                                    left: SizeConfig.widthMultiplier * 5),
                                child: Center(
                                    child: Text(
                                  sliderCont.timeList.value[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          SizeConfig.textMultiplier * 2.5),
                                )),
                              ),
                            )
                          ],
                        ),
                );
              }),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1.5,
              ),
              widget.isAddTask
                  ? const SizedBox()
                  : const HeadingContainer(
                      text: "Remove Task",
                    ),
              widget.isAddTask
                  ? const SizedBox()
                  : InkWell(
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection("Users")
                            .doc(sliderCont.uid.value)
                            .collection("TaskOptions")
                            .doc(widget.taskID)
                            .delete()
                            .then((value) {
                          Get.back();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 114, 114),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 6)
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.heightMultiplier * 1,
                            horizontal: SizeConfig.widthMultiplier * 3),
                        margin: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 3,
                            bottom: SizeConfig.heightMultiplier * 3,
                            left: SizeConfig.widthMultiplier * 5),
                        child: const Text(
                          "Remove",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    )
            ],
          ),
        ));
  }
}
