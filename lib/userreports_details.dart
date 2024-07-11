import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecordDetailPage extends StatelessWidget {
  final Uri uploadedFileUrl;
  final Uri diagnosisFileUrl;

  RecordDetailPage({required this.uploadedFileUrl, required this.diagnosisFileUrl});

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
                    _buildTile(context, 'Upload Report', uploadedFileUrl),
                    SizedBox(height: 20), // Space between the tiles
                    _buildTile(context, 'Diagnosis Report', diagnosisFileUrl),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, String title, Uri fileUrl) {
    return GestureDetector(
      onTap: () => _launchUrl(fileUrl),
      child: Container(
        width: 150, // Keep the width same as previous tiles
        height: 150, // Keep the height same as previous tiles
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blueAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 20,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri _url) async {
    print('URL IS************: $_url');
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
