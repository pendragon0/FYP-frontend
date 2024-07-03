import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ScanPDF extends StatefulWidget {
  @override
  _ScanPDFState createState() => _ScanPDFState();
}

class _ScanPDFState extends State<ScanPDF> {
  List<TestResult> _testResults = [];
  String? _prompt;
  bool _isLoading = false;
  bool _isDiagnosisLoading = false;
  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _isLoading = true;
      });

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
      

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _uploadPDF(File file) async {
    final uri = Uri.parse("http://192.168.18.101:8080/api/API/upload/");
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final decodedData = json.decode(responseData);
      final results = decodedData.entries.map<TestResult>((entry) {
        return TestResult(attribute: entry.key, value: entry.value.toString());
      }).toList();

      setState(() {
        _testResults = results;
      });
    } else {
      setState(() {
        _testResults = [];
      });
      print('Error: ${response.statusCode}');
    }
  }


  Future<void> _getDiagnosis() async {
    final uri = Uri.parse('http://192.168.18.101:8080/api/API/upload/');
    // var request = http.MultipartRequest('POST', uri);
    final response = await http.get(uri);
    
    if (response.statusCode == 200){
      final decodedData = json.decode(response.body);
      _prompt = decodedData['prompt'];
      setState(() {
        
        _isDiagnosisLoading = true;
      });

    }else{

    setState(() {
      _isDiagnosisLoading = false;
    });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Report Analyzer'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //UPLOAD PDF BUTTON ********************
                  ElevatedButton(
                    onPressed: _pickDocument,
                    child: Text('Upload PDF Document'),
                  ),
                  //GET DIAGNOSIS BUTTON *****************

                  ElevatedButton(
                    onPressed: _getDiagnosis,
                    child: Text('Diagnose')),
                  SizedBox(height: 20),
                  _testResults.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _testResults.length,
                            itemBuilder: (context, index) {
                              final result = _testResults[index];
                              return ListTile(
                                title: Text(result.attribute),
                                subtitle: Text(result.value),
                              );
                            },
                          ),
                        )
                      : Text('No results to display'),


                ],
              ),
      ),
    );
  }
}

class TestResult {
  final String attribute;
  final String value;

  TestResult({required this.attribute, required this.value});
}
