import 'package:flutter/material.dart';
import 'package:projm/models/shareddata.dart';
import 'package:projm/models/testresults.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatelessWidget {
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

    final List<_ChartData> chartData = [
      _ChartData('RBC Count', attributes['RBC Count']!, Colors.red),
      _ChartData('WBC Count', attributes['WBC Count']!, Colors.blue),
      // _ChartData('Platelets', attributes['Platelets']!, Colors.green),
      _ChartData('Hemoglobin', attributes['Hemoglobin']!, Colors.orange),
    ];

    double? attribute_value = attributes['Platelets'];
    String attribute_name = attributes.keys.elementAt(2);

    return Container(
      margin: EdgeInsets.only(top: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Blood Test Analysis',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 1.3,
            child: SfCircularChart(
              series: <CircularSeries>[
                DoughnutSeries<_ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (_ChartData data, _) => data.category,
                  yValueMapper: (_ChartData data, _) => data.value,
                  pointColorMapper: (_ChartData data, _) => data.color,
                  innerRadius: '80%',
                  radius: '80%',
                  cornerStyle: CornerStyle.bothCurve, // To add rounded corners
                  strokeWidth: 3, // To create the gap effect
                  strokeColor: Colors.white, // Color of the gap
                  dataLabelSettings: DataLabelSettings(
                    isVisible: false,
                  ),
                ),
              ],
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "$attribute_value",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '10^6',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '/uL',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              LegendItem(
                color: chartData[0].color,
                text: '${chartData[0].category}: ${chartData[0].value} 10^6/uL',
              ),
              SizedBox(height: 8),
              LegendItem(
                color: chartData[1].color,
                text: '${chartData[1].category}: ${chartData[1].value} 10^3/uL',
              ),
              SizedBox(height: 8),
              LegendItem(
                color: chartData[2].color,
                text: '${chartData[2].category}: ${chartData[2].value} g/dL',
              ),
              SizedBox(height: 8),
              LegendItem(
                color: Colors.green,
                text: '$attribute_name: $attribute_value 10^6 /uL',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  final String category;
  final double value;
  final Color color;

  _ChartData(this.category, this.value, this.color);
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 12,
          color: color,
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
