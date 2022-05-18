import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/all_buttons_controller.dart';
import '../../../../utils/size_config.dart';

class SelectColor extends StatelessWidget {
  const SelectColor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    final colorsCont = Get.put(AllButtonsController());
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.heightMultiplier * 2,
          left: SizeConfig.widthMultiplier * 5),
      child: Row(
        children: [
          ...List.generate(
              colors.length,
              (index) => Obx(
                    () => Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.widthMultiplier * 1),
                      child: InkWell(
                        onTap: () {
                          colorsCont.selectedColorIndex.value = index;
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: colors[index],
                              radius: SizeConfig.widthMultiplier * 5,
                            ),
                            colorsCont.selectedColorIndex.value == index
                                ? const Icon(Icons.done, color: Colors.white)
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}