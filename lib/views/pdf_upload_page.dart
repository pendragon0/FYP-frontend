import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:projm/models/shareddata.dart';
import 'package:projm/models/testresults.dart';

class PdfUploadPage extends StatefulWidget {
  @override
  _PdfUploadPageState createState() => _PdfUploadPageState();
}

class _PdfUploadPageState extends State<PdfUploadPage> {
  String? _fileName;

Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {

      File file = File(result.files.single.path!);

      // Save the picked PDF to the application's document directory
      final directory = await getApplicationDocumentsDirectory();
      final pdfPath = "${directory.path}/${result.files.single.name}";
      await file.copy(pdfPath);
      print("PDF PATH**************: $pdfPath");

      // Send the PDF to the Django API
      try {

        await _uploadPDF(file);

      } catch(e){
        print('ERROR PRINTED: $e');
      }
    

    }
  

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    }
  }


String email = 'wagamo112@gmail.com';
Future<void> _uploadPDF(File file) async {

  //API KEY TO DJANGO SERVER
  final uri = Uri.parse("http://192.168.18.101:8080/api/API/upload/");
    var request = http.MultipartRequest('POST', uri);
    request.fields['email'] = email;
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final decodedData = json.decode(responseData);
      final results = decodedData.entries.map<TestResult>((entry) {
        return TestResult(attribute: entry.key, value: entry.value.toString());
      }).toList();

      testResults = results;
    //   setState(() {
    //     testResults = results;
    //   });
    // } else {
    //   setState(() {
    //     testResults = [];
    //   });
    } else {
      print('Error: ${response.statusCode}');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar with gradient background
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context)
                    .padding
                    .top), // Add padding for the status bar
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
                        'Upload PDF',
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
            child: Stack(
              children: [
                // Background color set to white
                Container(
                  color: Colors.white,
                ),
                // Background image
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/pdfbackground.png'), // Path to your background image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Content
                Center(
                  child: _fileName == null
                      ? Container() // Display nothing if no PDF is selected
                      : Padding(
                          padding: const EdgeInsets.only(
                              top:
                                  350.0), // Adjust the value to move the text down
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Selected PDF: $_fileName',
                              style: TextStyle(
                                color: Colors
                                    .black, // Ensure text color is visible over background
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickDocument,
        tooltip: 'Pick PDF',
        backgroundColor: Color(0xFF0099FF), // Updated color to #0099FF
        child: Icon(Icons.picture_as_pdf,
            color: Colors.white), // Icon color set to white
      ),
    );
  }
}
