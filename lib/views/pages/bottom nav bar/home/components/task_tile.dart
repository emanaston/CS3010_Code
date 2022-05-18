import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/size_config.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    List<String> myTaskAlphabets = [
      "A",
      "B",
      "C",
      "D",
      "E",
    ];
    List<String> myTaskSubtitles = [
      "Very important",
      "Should do",
      "Nice to do",
      "Delegate",
      "Eliminate",
    ];
    return Container(
      height: SizeConfig.heightMultiplier * 13,
      width: SizeConfig.widthMultiplier * 90,
      margin: EdgeInsets.only(
          top: index == 0 ? 0 : SizeConfig.heightMultiplier * 2),
      decoration: BoxDecoration(
          color: defaultTileColor,
          borderRadius: BorderRadius.circular(2),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)]),
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier * 0.5,
          horizontal: SizeConfig.widthMultiplier * 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            myTaskAlphabets[index],
            style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 6,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          Text(
            "(${myTaskSubtitles[index]})",
            style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          )
        ],
      ),
    );
  }
}
