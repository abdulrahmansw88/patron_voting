import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patron_voting/utils/colors.dart';

import 'popular_character_controller.dart';

class PopularCharacters extends StatelessWidget {
   PopularCharacters({Key? key}) : super(key: key);
  final controller = Get.put(PopularCharacterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Character"),
      ),
      body: controller.obx(
          (state)=> PieChart(
          PieChartData(
              centerSpaceRadius: 10,
              centerSpaceColor: Colors.white,
              pieTouchData: PieTouchData(
                enabled: true,
              ),
              sections: List.generate(controller.popularData.length, (index) {
                return PieChartSectionData(
                    radius: 110,
                    badgePositionPercentageOffset: 1.3,
                    showTitle: true,
                    badgeWidget: Text("${controller.popularData[index]['name']}"),
                    // title: "${controller.popularData[index]['name']}",
                    value: double.parse(controller.popularData[index]['noOfVotes']), color: controller.colorData[index]);
              })
          ),
        ),
      ),
    );
  }
}
