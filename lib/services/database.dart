import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataBase {
  final _firestore = FirebaseFirestore.instance;
  Future<void> addNotes(
      String title,
      String mainTaskAlphabet,
      String weighting,
      int colorIndex,
      String description,
      List time,
      double progress,
      String uid,
      List milisecondTime) async {
    try {
      _firestore.collection("Users").doc(uid).collection("TaskOptions").add({
        "Title": title,
        "MainTask": mainTaskAlphabet,
        "Weighting": weighting,
        "ColorIndex": colorIndex,
        "Description": description,
        "Time": time,
        "MilisecondsTime": milisecondTime,
        "DelegateTo": "",
        "Progress": progress,
        "Date": DateTime.now().toString()
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> updateNotes(
      String notesID,
      String title,
      String mainTaskAlphabet,
      String weighting,
      int colorIndex,
      String description,
      List time,
      double progress,
      String uid,
      List milisecondTime) async {
    try {
      _firestore
          .collection("Users")
          .doc(uid)
          .collection("TaskOptions")
          .doc(notesID)
          .update({
        "Title": title,
        "MainTask": mainTaskAlphabet,
        "Weighting": weighting,
        "ColorIndex": colorIndex,
        "Description": description,
        "Time": time,
        "MilisecondsTime": milisecondTime,
        "Progress": progress,
        "Date": DateTime.now().toString()
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
