import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasksadd/controllers/all_buttons_controller.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/size_config.dart';

class DelegateToDialog extends StatefulWidget {
  const DelegateToDialog({
    Key? key,
    required this.taskID,
  });
  final String taskID;
  @override
  State<StatefulWidget> createState() => DelegateToDialogState();
}

class DelegateToDialogState extends State<DelegateToDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }
 TextEditingController delegateCont = TextEditingController();
 final cont =  Get.put(AllButtonsController());
  @override
  Widget build(BuildContext context) {
   
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
              height: 21 * SizeConfig.heightMultiplier,
              width: 70 * SizeConfig.widthMultiplier,
              decoration: ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(00))),
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 1,
                  horizontal: SizeConfig.widthMultiplier * 5),
              child: Column(
                children: [
                   Text(
                    "Delegate to",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black,fontSize: SizeConfig.textMultiplier*2.5),
                  ),
                  TextField(
                    controller: delegateCont,
                    autofocus: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier*2,),
                  Center(
                    child: InkWell(
                      onTap: () {
                        if (delegateCont.text.isNotEmpty) {
                          FirebaseFirestore.instance
                              .collection("Users")
                              .doc(cont.uid.value)
                              .collection("TaskOptions")
                              .doc(widget.taskID)
                              .update({"DelegateTo": delegateCont.text});

                              cont.delegateTo.value=delegateCont.text;
                              Get.back();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please enter name")));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:     const Color(0xFF8CE4A0),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 6)
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.heightMultiplier * 1.2,
                            horizontal: SizeConfig.widthMultiplier * 8),
                        margin: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 1,
                            left: SizeConfig.widthMultiplier * 2),
                        child: const Text(
                          "Add",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                ],
              )),
        ),
      ),
    );
  }
}
