import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projm/models/shareddata.dart';
import 'package:projm/models/testresults.dart';


String email = 'wagamo112@gmail.com';
Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
    //   setState(() {
    //     _isLoading = true;
    //   });

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
      

      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

Future<void> _uploadPDF(File file) async {


  final uri = Uri.parse("http://192.168.100.85:8080/api/API/upload/");
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
      print('Error: ${response.statusCode}');
    }
  }
