import 'package:flutter/material.dart';
import 'package:projm/controllers/model_controller.dart';

import 'care_suggestion.dart'; // Import the CareSuggestionPage when ready
import 'chart_widget.dart';
import 'comparison_widget.dart';
import 'report_summary.dart'; // Import the ReportSummaryPage
import 'table_widget.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Custom AppBar with gradient background
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top), // Add padding for the status bar
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0099FF), Color(0xFF36D1DC)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            'Statistics',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ProximaNova',
                            ),
                          ),
                          SizedBox(
                              width: 48), // Placeholder to balance the back button
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20), // Add space between the AppBar and the tiles
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildTile(
                              context,
                              'report summary tile.png',
                              'report summary icon.png',
                              'reportSummary', // Pass a string identifier for navigation
                            ),
                            _buildTile(
                              context,
                              'care suggestion tile.png',
                              'care suggestion icon.png',
                              'careSuggestion', // Pass a string identifier for navigation
                            ),
                          ],
                        ),
                        SizedBox(
                            height:
                                30), // Add space between the tiles and the rest of the content
                        ChartWidget(),
                        ComparisonWidget(),
                        TableWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Show a loading indicator while loading
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTile(
      BuildContext context, String backgroundImage, String iconImage, String targetPage) {
    return GestureDetector(
      onTap: () async {
        if (targetPage == 'reportSummary') {
          setState(() {
            _isLoading = true;
          });
          String diagnosis = await generatingText();
          setState(() {
            _isLoading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReportSummaryPage(diagnosis: diagnosis)),
          );
        } else if (targetPage == 'careSuggestion') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CareSuggestionPage()),
          );
        } else {
          // Handle case where there is no navigation yet
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Feature coming soon!')),
          );
        }
      },
      child: _buildTileContent(backgroundImage, iconImage),
    );
  }

  Widget _buildTileContent(String backgroundImage, String iconImage) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$backgroundImage'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 15,
                offset: Offset(0, 10), // changes position of shadow
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -30, // Adjust this value to move the icon partially outside
          right: -20, // Adjust this value to position the icon to the right
          child: Image.asset(
            'assets/$iconImage',
            width: 90, // Increase the width
            height: 90, // Increase the height
          ),
        ),
      ],
    );
  }
}

