import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:projm/controllers/model_controller.dart';

import 'care_suggestion.dart'; // Import the CareSuggestionPage when ready
import 'chart_widget.dart';
import 'comparison_widget.dart';
import 'report_summary.dart'; // Import the ReportSummaryPage
import 'table_widget.dart';

class StatisticsPage extends StatefulWidget {
  
  final String report_identifier1;

  
  StatisticsPage(this.report_identifier1);
  @override
  _StatisticsPageState createState() => _StatisticsPageState(report_identifier1);
}

class _StatisticsPageState extends State<StatisticsPage> {

  final String report_identifier;
  _StatisticsPageState(this.report_identifier);
  bool _isLoading = false;
  bool _summaryVisited = false;
  bool _cureVisited = false;
  final GlobalKey chartKey = GlobalKey();
  final GlobalKey graphKey = GlobalKey();
  final GlobalKey tableKey = GlobalKey();
  final GlobalKey summaryKey = GlobalKey();
  final GlobalKey cureKey = GlobalKey();

  Uint8List? chartImage;
  Uint8List? graphImage;
  Uint8List? tableImage;
  Uint8List? summaryImage;
  Uint8List? cureImage;

  Future<Uint8List?> _capturePng(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      print('Widget Captured********************');
      return byteData?.buffer.asUint8List();
    } catch (e) {
      
      print('Widget Not captured********************: $e');
      return null;
    }
  }

  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    if (chartImage != null) {
      print('ChartImage is not null');

      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(child: pw.Image(pw.MemoryImage(chartImage!)));
      }));
    }

    if (graphImage != null) {
      print('GraphImage is not null');
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(child: pw.Image(pw.MemoryImage(graphImage!)));
      }));
    }
    if (tableImage != null) {
      print('tableImage is not null');
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(child: pw.Image(pw.MemoryImage(tableImage!)));
      }));
    }
    

    if (summaryImage != null) {
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(child: pw.Image(pw.MemoryImage(summaryImage!)));
      }));
    }

    if (cureImage != null) {
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(child: pw.Image(pw.MemoryImage(cureImage!)));
      }));
    }
    
    // Save PDF to file with a unique name everytime
    final output = await getTemporaryDirectory();
    final String filename = 'MEDSCAN_00${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File("${output.path}/$filename");
    await file.writeAsBytes(await pdf.save());

    try{
      await _sendToServer(file);
    } catch(e){
      print(e);
    }

    // Optionally, preview the PDF
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  // String reportIdentifier = report_identifier;
  
  final String email = 'wagamo112@gmail.com';
  Future<void> _sendToServer(File file) async {
    final uri = Uri.parse("http://192.168.100.242:8080/api/API/upload/");
    var request = http.MultipartRequest('POST', uri);
    request.fields['email'] = email;
    request.fields['report_identifier'] = report_identifier;
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    
    var response = await request.send();
    if (response.statusCode == 200) {
      print('SENT TO THE SERVER SUCCESSFULLY');
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  


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
                        RepaintBoundary(key: chartKey, child: ChartWidget()),
                        RepaintBoundary(key: graphKey, child: ComparisonWidget()),
                        RepaintBoundary(key: tableKey, child: TableWidget()),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _summaryVisited && _cureVisited ? _generatePdf : null, // Enable only if both pages are visited
        child: Icon(Icons.picture_as_pdf),
      ),
    );
  }

  Widget _buildTile(
      BuildContext context, String backgroundImage, String iconImage, String targetPage) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isLoading = true;
        });

        String diagnosis = await generatingText();

        setState(() {
          _isLoading = false;
        });

        if (targetPage == 'reportSummary') {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RepaintBoundary(key: summaryKey, child: ReportSummaryPage(diagnosis: diagnosis))),
          );
          // Capture the screenshot after returning from ReportSummaryPage
          summaryImage = await _capturePng(summaryKey);
          setState(() {
            _summaryVisited = true;
          });
        } else if (targetPage == 'careSuggestion') {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RepaintBoundary(key: cureKey, child: CareSuggestionPage(diagnosis: diagnosis))),
          );
          // Capture the screenshot after returning from CareSuggestionPage
          cureImage = await _capturePng(cureKey);
          setState(() {
            _cureVisited = true;
          });
        } else {
          // Handle case where there is no navigation yet
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Feature coming soon!')),
          );
        }

        // Capture chart and graph images only once after the first navigation
        if (chartImage == null) {
          chartImage = await _capturePng(chartKey);
        }
        if (graphImage == null) {
          graphImage = await _capturePng(graphKey);
          print('graphimaging captured#############');
        }
        if (tableImage == null){
          tableImage = await _capturePng(tableKey);
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

