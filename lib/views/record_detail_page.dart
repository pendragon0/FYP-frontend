import 'package:flutter/material.dart';

class RecordDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                        'Record Details',
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
          Expanded(
            child: Container(
              color: Colors.white, // Set background color to white
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTile(context, 'upload report tile.png', _handleUploadReportTap),
                    SizedBox(height: 20), // Space between the tiles
                    _buildTile(context, 'generate report tile.png', _handleGenerateReportTap),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, String backgroundImage, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150, // Keep the width same as previous tiles
        height: 150, // Keep the height same as previous tiles
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage('assets/$backgroundImage'),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 20,
              offset: Offset(0, 6),
            ),
          ],
        ),
      ),
    );
  }

  void _handleUploadReportTap() {
    // Handle the upload report tile tap
    print('Upload Report tapped');
    // Add your functionality here
  }

  void _handleGenerateReportTap() {
    // Handle the generate report tile tap
    print('Generate Report tapped');
    // Add your functionality here
  }
}
