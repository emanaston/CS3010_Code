import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasksadd/constants/colors.dart';
import 'package:tasksadd/controllers/all_buttons_controller.dart';
import 'package:tasksadd/utils/size_config.dart';
import 'package:tasksadd/views/widgets/custom_appbar.dart';

import 'components/pie_chart.dart';
import 'components/select_duartion.dart';
import 'components/total_task.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<String> setDuration = [
    "Past Week",
    "Past 2 Weeks",
    "Past Month",
    "Past Year"
  ];
  final checkBoxCont = Get.find<AllButtonsController>();
  final cont = Get.find<AllButtonsController>();
  @override
  void dispose() {
    cont.aPercentage.value = 0;
    cont.bPercentage.value = 0;
    cont.cPercentage.value = 0;
    cont.ePercentage.value = 0;
    super.dispose();
  }
  int? randomETaskValue;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      setState(() {});
    });
    var rng =  Random();
    print("This is random value ${rng.nextInt(3)}");
    randomETaskValue=rng.nextInt(2);
  }
  List<String> recommendationsOfETasks=[
    "Please reduce the amount of time you spend on E tasks",
    "Please focus more on A Tasks!"
  ];
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(cont.uid.value)
        .collection("TaskOptions")
        .get()
        .then((value) {
      cont.totalNumberOfTasks.value = 0;
      for (int i = 0; i < value.docs.length; i++) {
        for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
          cont.totalNumberOfTasks.value = cont.totalNumberOfTasks.value +
              value.docs[i]["MilisecondsTime"][a] as int;
        }
      }
      print("Test stat is ${cont.totalNumberOfTasks.value}");
    });

    FirebaseFirestore.instance
        .collection("Users")
        .doc(cont.uid.value)
        .collection("TaskOptions")
        .where("MainTask", isEqualTo: "A")
        .get()
        .then((value) {
      if (cont.selectDurationIndex.value == 0) {
        cont.aPercentage.value = 0;
        cont.aPercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 7)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.aPercentage.value = cont.aPercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value of A : ${cont.aPercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 1) {
        cont.aPercentage.value = 0;
        cont.aPercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();

          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 14)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.aPercentage.value = cont.aPercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value of A : ${cont.aPercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 2) {
        cont.aPercentage.value = 0;
        cont.aPercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();

          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 30)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.aPercentage.value = cont.aPercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value of A : ${cont.aPercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 3) {
        cont.aPercentage.value = 0;
        cont.aPercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();

          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 365)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.aPercentage.value = cont.aPercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value of A : ${cont.aPercentage.value}")
              : print("asd");
        }
      }
    });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(cont.uid.value)
        .collection("TaskOptions")
        .where("MainTask", isEqualTo: "B")
        .get()
        .then((value) {
      if (cont.selectDurationIndex.value == 0) {
        cont.bPercentage.value = 0;
        cont.bPercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 7)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.bPercentage.value = cont.bPercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value og B : ${cont.bPercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 1) {
        cont.bPercentage.value = 0;
        cont.bPercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 14)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.bPercentage.value = cont.bPercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value og B : ${cont.bPercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 2) {
        cont.bPercentage.value = 0;
        cont.bPercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 30)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.bPercentage.value = cont.bPercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value og B : ${cont.bPercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 3) {
        cont.bPercentage.value = 0;
        cont.bPercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 365)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.bPercentage.value = cont.bPercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value og B : ${cont.bPercentage.value}")
              : print("asd");
        }
      }
    });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(cont.uid.value)
        .collection("TaskOptions")
        .where("MainTask", isEqualTo: "C")
        .get()
        .then((value) {
      if (cont.selectDurationIndex.value == 0) {
        cont.cPercentage.value = 0;
        cont.cPercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 7)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.cPercentage.value = cont.cPercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value og C : ${cont.cPercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 1) {
        cont.cPercentage.value = 0;
        cont.cPercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 14)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.cPercentage.value = cont.cPercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value og C : ${cont.cPercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 2) {
        cont.cPercentage.value = 0;
        cont.cPercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 30)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.cPercentage.value = cont.cPercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value og C : ${cont.cPercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 3) {
        cont.cPercentage.value = 0;
        cont.cPercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 365)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.cPercentage.value = cont.cPercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value og C : ${cont.cPercentage.value}")
              : print("asd");
        }
      }
    });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(cont.uid.value)
        .collection("TaskOptions")
        .where("MainTask", isEqualTo: "E")
        .get()
        .then((value) {
      if (cont.selectDurationIndex.value == 0) {
        cont.ePercentage.value = 0;
        cont.ePercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 7)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.ePercentage.value = cont.ePercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value og E : ${cont.ePercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 1) {
        cont.ePercentage.value = 0;
        cont.ePercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 14)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.ePercentage.value = cont.ePercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value og E : ${cont.ePercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 2) {
        cont.ePercentage.value = 0;
        cont.ePercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 30)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.ePercentage.value = cont.ePercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value og E : ${cont.ePercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 3) {
        cont.ePercentage.value = 0;
        cont.ePercentageTotal.value = value.docs.length;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 365)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            for (int a = 0; a < value.docs[i]["MilisecondsTime"].length; a++) {
              cont.ePercentage.value = cont.ePercentage.value +
                  value.docs[i]["MilisecondsTime"][a] as int;
            }
          }
          i == value.docs.length - 1
              ? print("This is the last value og E : ${cont.ePercentage.value}")
              : print("asd");
        }
      }
    });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(cont.uid.value)
        .collection("TaskOptions")
        .where("MainTask", isEqualTo: "D")
        .get()
        .then((value) {
      if (cont.selectDurationIndex.value == 0) {
        cont.dLength.value = 0;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 7)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            cont.dLength.value = cont.dLength.value + 1;
          }
          i == value.docs.length - 1
              ? print("This is the last value og E : ${cont.ePercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 1) {
        cont.dLength.value = 0;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 14)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            cont.dLength.value = cont.dLength.value + 1;
          }
          i == value.docs.length - 1
              ? print("This is the last value og E : ${cont.ePercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 2) {
        cont.dLength.value = 0;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 30)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            cont.dLength.value = cont.dLength.value + 1;
          }
          i == value.docs.length - 1
              ? print("This is the last value og E : ${cont.ePercentage.value}")
              : print("asd");
        }
      }
      if (cont.selectDurationIndex.value == 3) {
        cont.dLength.value = 0;
        for (int i = 0; i < value.docs.length; i++) {
          final date = DateTime.now();
          final difference = DateTime.parse(value.docs[i]["Date"])
              .difference(date.subtract(const Duration(days: 365)));
          print("This is : ${difference.inDays}");
          print("This ${value.docs[i]["Date"]}");
          if (difference.inDays >= 5) {
            cont.dLength.value = cont.dLength.value + 1;
          }
          i == value.docs.length - 1
              ? print("This is the last value og E : ${cont.ePercentage.value}")
              : print("asd");
        }
      }
    });
    // List<int> numbers = [
    //   cont.aPercentage.value,
    //   cont.bPercentage.value,
    //   cont.cPercentage.value,
    //   cont.ePercentage.value
    // ];
    if((cont.aPercentage.value+cont.bPercentage.value+cont.cPercentage.value)<cont.ePercentage.value){
      cont.recomendationText.value = recommendationsOfETasks[randomETaskValue??0];
    }
    if(cont.aPercentage.value>(cont.bPercentage.value+cont.cPercentage.value+cont.ePercentage.value)){
      cont.recomendationText.value = "Well done! Keep focusing on A tasks!";
    }
    if(cont.aPercentage.value<(cont.bPercentage.value+cont.cPercentage.value)){
      cont.recomendationText.value = "Please focus more on A tasks!";
    }
    if((cont.aPercentage.value+cont.bPercentage.value+cont.cPercentage.value+cont.ePercentage.value)<=0){
      cont.recomendationText.value = "No recommendations yet!";
    }

    // int smallNumber = numbers.reduce(min);
    // for (int i = 0; i < numbers.length; i++) {
    //   if (numbers[i] == smallNumber) {
    //     if (i == 0) {
    //       cont.recomendationText.value = "Please Focus on A Tasks";
    //     }
    //     if (i == 1) {
    //       cont.recomendationText.value = "Please Focus on B Tasks";
    //     }
    //     if (i == 2) {
    //       cont.recomendationText.value = "Please Focus on C Tasks";
    //     }
    //     if (i == 3) {
    //       cont.recomendationText.value = "Please Focus on E Tasks";
    //     }
    //   }
    // }

    ///////////////////////////BODY OF THE STATS PAGE///////////////////////////////////////////
    return Scaffold(
      backgroundColor: const Color(0xFFEBE4E2),
      body: Column(
        children: [
          const CustomAppBar(title: "Visualization", isBackButton: false),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(cont.uid.toString())
                  .collection("TaskOptions")
                  .snapshots(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? SizedBox(
                  height: SizeConfig.heightMultiplier * 30,
                  width: SizeConfig.widthMultiplier * 100,
                )
                    : SizedBox(
                    height: SizeConfig.heightMultiplier * 30,
                    width: SizeConfig.widthMultiplier * 100,
                    child: snapshot.data!.docs.isNotEmpty
                        ? PieDefault()
                        : const Center(child: Text("No Data")));
              }),
          const AllTaskColorsWidget(),
          const TotalTaskWidget(),
          Container(
              width: SizeConfig.widthMultiplier * 55,
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 3),
              decoration: const BoxDecoration(
                color: Color(0xFFB2A4A3),
              ),
              child: Column(
                children: [
                  ListView.builder(
                      padding:
                      EdgeInsets.only(top: SizeConfig.heightMultiplier * 1),
                      shrinkWrap: true,
                      itemCount: setDuration.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.heightMultiplier * 1),
                        child: Obx(
                              () => InkWell(
                            onTap: () {
                              setState(() {});
                              checkBoxCont.selectDurationIndex.value =
                                  index;
                            },
                            child: Row(
                              children: [
                                Container(
                                    height: SizeConfig.heightMultiplier * 2,
                                    width: SizeConfig.widthMultiplier * 4,
                                    color: Colors.white,
                                    child: checkBoxCont.selectDurationIndex
                                        .value ==
                                        index
                                        ? Icon(Icons.done,
                                        size: SizeConfig
                                            .heightMultiplier *
                                            2)
                                        : const SizedBox()),
                                SizedBox(
                                  width: SizeConfig.widthMultiplier * 5,
                                ),
                                Text(setDuration[index],
                                    style: TextStyle(
                                        fontSize:
                                        SizeConfig.textMultiplier * 1.5,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              )),
          Container(
            height: SizeConfig.heightMultiplier * 7,
            width: SizeConfig.widthMultiplier * 55,
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Recomendation :",
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 1.5,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline),
                ),
                Obx(
                      () => Text(
                    cont.recomendationText.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AllTaskColorsWidget extends StatelessWidget {
  const AllTaskColorsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> alphabets = ["A", "B", "C", "E"];
    List<Color> colorsAlphabets = const [
      Color(0xFF4e85b7),
      Color(0xFFbb6f80),
      Color(0xFFf27680),
      Color(0xFFf6b194),
    ];
    return Container(
        height: SizeConfig.heightMultiplier * 7,
        width: SizeConfig.widthMultiplier * 55,
        padding:
        EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3),
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
          color: Color(0xFFD8CFCD),
        ),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ...List.generate(
              alphabets.length,
                  (index) => SizedBox(
                child: Row(children: [
                  CircleAvatar(
                      radius: SizeConfig.widthMultiplier * 1.2,
                      backgroundColor: colorsAlphabets[index]),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 1,
                  ),
                  Text(alphabets[index],
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 3,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87))
                ]),
              ))
        ]));
  }
}
