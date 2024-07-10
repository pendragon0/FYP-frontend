import 'package:flutter/material.dart';
import 'package:projm/models/shareddata.dart';
import 'package:projm/models/testresults.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ComparisonWidget extends StatelessWidget {
  final List<TestResult> results = testResults;

  @override
  Widget build(BuildContext context) {
    final Map<String, double> attributes = {
      'RBC Count': 0.0,
      'WBC Count': 0.0,
      'Platelets': 0.0,
      'Hemoglobin': 0.0,
    };

    // Populate the attributes map with values from testResults
    for (var result in results) {
      if (result.attribute == 'RBC') {
        attributes['RBC Count'] = double.tryParse(result.value) ?? 0.0;
      } else if (result.attribute == 'WBC') {
        attributes['WBC Count'] = double.tryParse(result.value) ?? 0.0;
      } else if (result.attribute == 'PLATELETS') {
        attributes['Platelets'] = double.tryParse(result.value) ?? 0.0;
      } else if (result.attribute == 'HB') {
        attributes['Hemoglobin'] = double.tryParse(result.value) ?? 0.0;
      }
    }

    final List<_ComparisonData> comparisonData = [
      _ComparisonData('RBC Count', attributes['RBC Count']!, 5.3, Colors.red),
      _ComparisonData('WBC Count', attributes['WBC Count']!, 10, Colors.blue),
      // _ComparisonData('Platelets', attributes['Platelets']!, 450, Colors.green),
      _ComparisonData('Hemoglobin', attributes['Hemoglobin']!, 13.5, Colors.orange),
    ];

    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.all(10.0), // Decreased padding value
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.0), // Push text upward
            child: Text(
              'Comparison of Actual and Normal Ranges',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'ProximaNova',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 15.0), // Move graph to the left
              child: AspectRatio(
                aspectRatio: 2.0, // Adjusted aspect ratio to make the container smaller
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    axisLine: AxisLine(width: 0),
                    minorGridLines: MinorGridLines(width: 0),
                    minorTicksPerInterval: 0,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ProximaNova',
                    ), // Style the axis labels
                    majorTickLines: MajorTickLines(size: 0),
                  ),
                  primaryYAxis: NumericAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    axisLine: AxisLine(width: 0),
                    labelStyle: TextStyle(
                        color: Colors.transparent), // Hide the axis labels
                    minorGridLines: MinorGridLines(width: 0),
                    minorTicksPerInterval: 0,
                    majorTickLines: MajorTickLines(size: 0),
                  ),
                  series: <ChartSeries>[
                    ColumnSeries<_ComparisonData, String>(
                      dataSource: comparisonData,
                      xValueMapper: (_ComparisonData data, _) => data.category,
                      yValueMapper: (_ComparisonData data, _) => data.actualValue,
                      name: 'Actual',
                      pointColorMapper: (_ComparisonData data, _) => data.color,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.middle,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'ProximaNova',
                        ), // Set text color to white for actual values
                        angle: -90, // Rotate text to be vertical
                      ),
                    ),
                    ColumnSeries<_ComparisonData, String>(
                      dataSource: comparisonData,
                      xValueMapper: (_ComparisonData data, _) => data.category,
                      yValueMapper: (_ComparisonData data, _) => data.normalValue,
                      name: 'Normal',
                      color: Color.fromARGB(255, 154, 243, 199),
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.middle,
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'ProximaNova',
                        ), // Keep text color black for normal values
                        angle: -90, // Rotate text to be vertical
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonData {
  final String category;
  final double actualValue;
  final double normalValue;
  final Color color;

  _ComparisonData(
      this.category, this.actualValue, this.normalValue, this.color);
}
