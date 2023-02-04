import 'package:flutter/material.dart';

import 'line_chart.dart';

class LineChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
    ),
    color: const Color(0xff020227),
    child: Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
          child: Column(
            children: [
              Expanded(child: LineChartWidget()),
              SizedBox(height: 20,),
              Text("Last 5 days Vote Stats"),
            ],
          )),
    ),
  );
}