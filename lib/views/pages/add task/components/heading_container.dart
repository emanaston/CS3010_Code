import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/size_config.dart';

class HeadingContainer extends StatelessWidget {
  const HeadingContainer({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 3.2,
      width: SizeConfig.widthMultiplier * 100,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        border: Border.all(color:Colors.white,width: 1)
      ),
      margin: EdgeInsets.only(top:text=="Time Spent" || text=="Timer" || text=="Priority"?0: SizeConfig.heightMultiplier * 2),
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
