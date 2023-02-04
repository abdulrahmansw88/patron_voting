
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'line_titles.dart';

class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      LineChart(
    LineChartData(
      minX: 0,
      maxX: 8,
      minY: 0,
      maxY: 10,
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        drawVerticalLine: false,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 1),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 2.5),
            FlSpot(8, 4),
          ],
          isCurved: true,
          barWidth: 5,
          // dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
          ),
        ),
      ],
      titlesData: FlTitlesData(
        show: false,
      )
    ),
  );
}