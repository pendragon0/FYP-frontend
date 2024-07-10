import 'package:flutter/material.dart';

class TableWidget extends StatelessWidget {
  final List<TestData> testData = [
    TestData('RBC Count', '0' , 'M/uL'),
    TestData('WBC Count', '11.0',  'K/uL'),
    TestData('Platelets', '250' ,'K/uL'),
    TestData('Hemoglobin', '14.5',' g/dL'),
    TestData('Glucose', '90' ,'mg/dL'),
    TestData('Cholesterol', '180','mg/dL'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Test Results',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Table(
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  Container(
                    color: Color(0xFF0099FF),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'TESTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: (Color(0xFFBBDEFB)).withOpacity(0.9),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.zero,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'VALUES',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              for (int i = 0; i < testData.length; i++)
                TableRow(
                  children: [
                    Container(
                      color: i % 2 == 0 ? Color(0xFFBBDEFB) : Colors.blue[50],
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        testData[i].testName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(1),
                        borderRadius: BorderRadius.only(
                          topRight: i == 0 ? Radius.circular(0) : Radius.zero,
                          bottomRight: i == testData.length - 1
                              ? Radius.circular(12)
                              : Radius.zero,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(testData[i].testValue),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class TestData {
  final String testName;
  final String testValue;
  final String testunit;

  TestData(this.testName, this.testValue, this.testunit);
}
