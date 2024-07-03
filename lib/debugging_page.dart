import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:projm/services/ocr_left2right.dart';
import 'package:projm/services/ocr_service.dart';


class ScanText extends StatefulWidget {
  @override
  _ScanTextState createState() => _ScanTextState();
}

class _ScanTextState extends State<ScanText> {
  final ImagePicker _picker = ImagePicker();
  List<TestResult> _testResults = [];
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });

      final imageFile = File(pickedFile.path);
      final extractor = TextExtractor();
      final results = await extractor.extractTextFromImage(imageFile);
      
      setState(() {
        // _testResults = results;
        _testResults = results as List<TestResult>;
        _isLoading = false;
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
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    child: Text('Upload Image'),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    child: Text('Take Picture'),
                  ),
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
