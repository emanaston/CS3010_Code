import 'package:flutter/material.dart';

import '../../../../utils/size_config.dart';

class TimerButtons extends StatelessWidget {
  const TimerButtons({
    Key? key,
    required this.title,
    required this.color,
    required this.press,
  }) : super(key: key);
  final String title;
  final Color color;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        height: SizeConfig.heightMultiplier * 4,
        width:title=="Resume"||title=="Pause"? SizeConfig.widthMultiplier * 16 :SizeConfig.widthMultiplier*14,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
        ),
        margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 3),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.textMultiplier * 1.8),
        )),
      ),
    );
  }
}
