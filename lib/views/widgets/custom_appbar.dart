import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../utils/size_config.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.isBackButton,
    this.donePress,
  }) : super(key: key);
  final String title;
  final bool isBackButton;
  final VoidCallback? donePress;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 13,
      width: SizeConfig.widthMultiplier * 100,
      color: kPrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isBackButton
                  ? TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back_ios_new_rounded,
                              size: 12, color: Colors.black),
                          Text(
                            "Back",
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.8,
                                color: Colors.black),
                          )
                        ],
                      ))
                  : SizedBox(
                      height: SizeConfig.heightMultiplier * 7,
                      width: SizeConfig.widthMultiplier * 15,
                    ),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.textMultiplier * 2.5),
              ),
             title == "Notes" || title == "Task Options"
              ? TextButton(
                  onPressed:donePress,
                  child: Text(
                    "Done",
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 1.8,
                        color: Colors.black),
                  ))
              :  SizedBox(width: SizeConfig.widthMultiplier * 15)
            ],
          ),
         SizedBox(height: SizeConfig.heightMultiplier * 0.5),
          const Divider(height: 1, thickness: 2, color: defaultTileColor)
        ],
      ),
    );
  }
}
