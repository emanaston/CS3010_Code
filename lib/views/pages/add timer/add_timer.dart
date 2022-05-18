import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:tasksadd/controllers/all_buttons_controller.dart';

import '../../../utils/size_config.dart';
import '../../widgets/custom_appbar.dart';
import '../add task/components/heading_container.dart';
import 'components/timer_button.dart';

class AddTimerPage extends StatefulWidget {
  const AddTimerPage({Key? key}) : super(key: key);

  @override
  State<AddTimerPage> createState() => _AddTimerPageState();
}

class _AddTimerPageState extends State<AddTimerPage> {

  final buttonCont = Get.find<AllButtonsController>();
  _getRequests() async {
    buttonCont.timeList;
    Get.back();
    buttonCont.timeList;
  }

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    onChange: (value) {
      final displayTime = StopWatchTimer.getDisplayTime(value);
      print('displayTime $displayTime');
    },
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );
  @override
  void dispose() {
    _stopWatchTimer.dispose();
    // Timer.periodic(const Duration(seconds: 1), (Timer t) => setState(() {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEAE4E2),
        body: StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: 0,
            builder: (context, snap) {
              final value = snap.data;
              final displayTime = StopWatchTimer.getDisplayTime(value!);
              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(
                        title: "Task Options",
                        isBackButton: true,
                        donePress: () {
                          setState(() {});

                          _getRequests();
                        },
                      ),
                      Container(
                        height: SizeConfig.heightMultiplier * 8,
                        width: SizeConfig.widthMultiplier * 100,
                        color: const Color(0xFFEAE4E2),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.heightMultiplier * 3),
                          child: const Center(
                            child: Text(
                              "Task",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                      ),
                      const HeadingContainer(
                        text: "Timer",
                      ),
                      Container(
                          height: SizeConfig.heightMultiplier * 15,
                          width: SizeConfig.widthMultiplier * 100,
                          color: const Color(0xFFDAD6D5),
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 2,
                              right: SizeConfig.widthMultiplier * 2,
                              bottom: SizeConfig.heightMultiplier * 3,
                              top: SizeConfig.heightMultiplier * 3),
                          child: Row(children: [
                            Container(
                                height: SizeConfig.heightMultiplier * 6,
                                width: SizeConfig.widthMultiplier * 42,
                                margin: EdgeInsets.only(left:SizeConfig.widthMultiplier*3),
                                color: const Color(0xFF837D7C),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    displayTime,
                                    style: TextStyle(
                                        fontSize: SizeConfig.textMultiplier * 3,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  // DPStopWatchWidget(
                                  //   stopwatchViewModel,
                                  // ),
                                ))),
                            const Spacer(),
                            TimerButtons(
                              press: () {
                                // Start
                                _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.start);
                                // stopwatchViewModel.start!.call();
                              },
                              title: "Start",
                              color: const Color(0xFFA4F2AB),
                            ),
                            TimerButtons(
                              press: () {
                                // Start
                                _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.stop);
                                print("This is milisecond val $value");
                                buttonCont.timeInMiliseconds.add(value);
                                print(
                                    "Let this ${buttonCont.timeInMiliseconds[0].toString()}");
                                value / 1000.toInt() <= 60
                                    ? buttonCont.timeList.add(
                                        "${((value / 1000) % 60).toInt()} seconds")
                                    : ((value / (1000 * 60)) % 60).toInt() <= 60
                                        ? buttonCont.timeList.add(
                                            "${((value / (1000 * 60)) % 60).toInt()} minutes")
                                        : (((value / (1000 * 60 * 60)) % 24)
                                                    .toInt() >
                                                5
                                            ? buttonCont.timeList.add(
                                                "${(((value / (1000 * 60 * 60)) % 24).toInt())} hours")
                                            : print("Null"));
                                setState(() {});
                              },
                              title: "Stop",
                              color: const Color(0xFFFF7A7A),
                            ),
                            // Obx(
                            //   () => TimerButtons(
                            //     press: () {
                            //       // buttonCont.isPause.value = !buttonCont.isPause.value;
                            //       // if (buttonCont.isPause.value == false) {
                            //       //   stopwatchViewModel.pause!.call();
                            //       // } else {
                            //       //   stopwatchViewModel.resume!.call();
                            //       // }
                            //     },
                            //     title: buttonCont.isPause.value ? "Pause" : "Resume",
                            //     color: const Color(0xFFC8C7C7),
                            //   ),
                            // ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 5,
                            )
                          ])),
                      const HeadingContainer(
                        text: "Time Spent",
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 3,
                            bottom: SizeConfig.heightMultiplier * 1,
                            left: SizeConfig.widthMultiplier * 5),
                        child: Text(
                          "Your total time spent on this task is:",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.textMultiplier * 1.8,
                              color: Colors.black87),
                        ),
                      ),
                      Obx(
                        () => Wrap(
                          children: [
                            ...List.generate(
                              buttonCont.timeList.value.length,
                              (index) => Container(
                                height: SizeConfig.heightMultiplier * 6,
                                width: SizeConfig.widthMultiplier * 35,
                                color: const Color(0xFF837D7C),
                                margin: EdgeInsets.only(
                                    top: SizeConfig.heightMultiplier * 2,
                                    left: SizeConfig.widthMultiplier * 5),
                                child: Center(
                                    child: Text(
                                  buttonCont.timeList.value[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          SizeConfig.textMultiplier * 2.5),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 5,
                      )
                    ]),
              );
            }));
  }
}
