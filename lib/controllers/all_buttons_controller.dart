import 'package:get/get.dart';

class AllButtonsController extends GetxController {
  var selectDurationIndex = 0.obs;
  var selectedColorIndex = 0.obs;
  var taskDescription = "Tap to add a description to this task...".obs;
  var delegateTo = "Tap to delegate this task...".obs;
  var timeList = [].obs;
  RxList timeInMiliseconds=[].obs;
  RxInt totalTime=0.obs;
  var sliderVal = 40.00.obs;
  var uid = "".obs;
  var isPause = true.obs;
  var totalNumberOfTasks = 0.obs;
  var aPercentage = 0.obs;
  var bPercentage = 0.obs;
  var cPercentage = 0.obs;
  var ePercentage = 0.obs;
  var dLength=0.obs;
  var aPercentageTotal = 0.obs;
  var bPercentageTotal = 0.obs;
  var cPercentageTotal = 0.obs;
  var ePercentageTotal = 0.obs;
  var isTaskIsAdding=false.obs;
  var recomendationText="".obs;
}
