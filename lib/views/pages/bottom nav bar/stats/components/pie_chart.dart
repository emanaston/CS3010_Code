/// Package import
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tasksadd/controllers/all_buttons_controller.dart';

/// Local imports
import '../../../../../models/sample_view.dart';

/// Render the default pie series.
class PieDefault extends StatefulWidget {
  @override
  _PieDefaultState createState() => _PieDefaultState();
}

/// State class of pie series.
class _PieDefaultState extends State<PieDefault> {
  _PieDefaultState();

  @override
  Widget build(BuildContext context) {
    final cont = Get.put(AllButtonsController());
    return Obx(() => buildDefaultPieChart(
        (cont.aPercentage.value / cont.totalNumberOfTasks.value) * 100,
        (cont.bPercentage.value / cont.totalNumberOfTasks.value) * 100,
        (cont.cPercentage.value / cont.totalNumberOfTasks.value) * 100,
        (cont.ePercentage.value / cont.totalNumberOfTasks.value) * 100));
  }

  /// Returns the circular  chart with pie series.
  SfCircularChart buildDefaultPieChart(
      firstVal, secondVal, thirdVal, forthVal) {
    return SfCircularChart(
      title: ChartTitle(text: ''),
      
      legend: Legend(isVisible: false),
      series: _getDefaultPieSeries(firstVal.toInt(), secondVal.toInt(),
          thirdVal.toInt(), forthVal.toInt()),
    );
  }

  /// Returns the pie series.
  List<PieSeries<ChartSampleData, String>> _getDefaultPieSeries(
      firstVal, secondVal, thirdVal, forthVal) {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          explode: false,
          explodeIndex: 0,
          explodeOffset: '10%',
          dataSource: <ChartSampleData>[
            ChartSampleData(x: 'a', y: firstVal, text: '$firstVal%'),
            ChartSampleData(x: 'b', y: secondVal, text: '$secondVal%'),
            ChartSampleData(x: 'c', y: thirdVal, text: '$thirdVal%'),
            ChartSampleData(x: 'e', y: forthVal, text: '$forthVal%'),
          ],
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          startAngle: 90,
          endAngle: 90,
          dataLabelSettings: const DataLabelSettings(isVisible: true)),
    ];
  }
}
