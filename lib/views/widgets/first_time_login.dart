import 'dart:async';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import '../../../../utils/size_config.dart';
import '../../constants/colors.dart';

class FirstTimeLoginDialog extends StatefulWidget {
  const FirstTimeLoginDialog({
    Key? key,
  });
  @override
  State<StatefulWidget> createState() => FirstTimeLoginDialogState();
}

class FirstTimeLoginDialogState extends State<FirstTimeLoginDialog>
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
              height: 20 * SizeConfig.heightMultiplier,
              width: 70 * SizeConfig.widthMultiplier,
              decoration: ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 3,
                  horizontal: SizeConfig.widthMultiplier * 5),
              child: Column(
                children: [
                  const Text(
                    "Welcome in our app",
                    style: TextStyle(
                        fontWeight: FontWeight.w800, color: kSecondaryColor),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  Text(
                    "This is just for one time data is loading",
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 1.6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: SizedBox(
                        height: SizeConfig.heightMultiplier * 3,
                        width: SizeConfig.heightMultiplier * 3,
                        child: const CircularProgressIndicator(
                            color: kSecondaryColor)),
                  ),
                   SizedBox(height: SizeConfig.heightMultiplier * 1),
                ],
              )),
        ),
      ),
    );
  }
}
