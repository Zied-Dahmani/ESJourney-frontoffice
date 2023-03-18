import 'package:esjourney/data/models/challenges/codingProblem/topSolutions/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProblemsChart extends StatelessWidget {
  const ProblemsChart({
    super.key,
    required TooltipBehavior tooltip,
    required this.width,
    required this.data,
  }) : _tooltip = tooltip;

  final TooltipBehavior _tooltip;
  final double width;
  final List<ChartData> data;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      borderWidth: 0,
      plotAreaBackgroundColor: Colors.white,
      borderColor: Colors.transparent,
      primaryXAxis: CategoryAxis(
          isVisible: false, majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis:
          NumericAxis(isVisible: false, minimum: 0, maximum: 50, interval: 50),
      tooltipBehavior: _tooltip,
      series: <ChartSeries<ChartData, String>>[
        ColumnSeries<ChartData, String>(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
          ),
          //
          width: width * 0.0008,
          dataSource: data,
          xValueMapper: (ChartData data, _) => data.memory,
          yValueMapper: (ChartData data, _) => data.percentage,
          name: '',
          color: const Color(0xFF3EB8D4),
        )
      ],
    );
  }
}

