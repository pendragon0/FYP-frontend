import 'dart:convert';
import 'dart:io'; // Import the dart:io library

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:projm/models/shareddata.dart';
import 'package:projm/models/testresults.dart';


class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;

    });

    if (_image != null){
      try {
        await _uploadImg(File(_image!.path));
      } catch(e) {
        print('Error Uploading: $e');
      }
    }
  }

String reportIdentifier = DateTime.now().millisecondsSinceEpoch.toString();
String email = 'wagamo112@gmail.com';
Future<void> _uploadImg(File file) async {

  //API KEY TO DJANGO SERVER
  final uri = Uri.parse("http://192.168.100.85:8080/api/API/upload/");
    var request = http.MultipartRequest('POST', uri);
    request.fields['email'] = email;
    request.fields['report_identifier'] = reportIdentifier;
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    
    var response = await request.send();
    print('IMAGE ADDED*****');
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
                        'Camera',
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
                          'assets/camerabackground.png'), // Path to your background image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Content
                Center(
                  child: _image != null
                      ? Image.file(File(_image!.path))
                      : Container(), // Display nothing if no image is selected
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCamera,
        tooltip: 'Open Camera',
        backgroundColor: Color(0xFF0099FF), // Updated color to #0099FF
        child:
            Icon(Icons.camera, color: Colors.white), // Icon color set to white
      ),
    );
  }
}
