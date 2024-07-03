import 'dart:io';

import 'package:google_ml_kit/google_ml_kit.dart';

class TextExtractor {
  Future<List<TestResult>> extractTextFromImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    textRecognizer.close();
    String text = recognizedText.text;
    print('TEXT#############: $text');
    return _parseText(recognizedText.text);
    
  }


  List<TestResult> _parseText(String text) {
    Map<String, String> results = {};
    Set<String> matchedValues = {};

    // print(lines);

    // Define a list of attributes
    final List<String> attributes = [
      'HAEMOGLOBIN', 'HAEMATOCRIT', 'R.B.C.', 'M.C.V.', 'M.C.H.',
      'M.C.H.C.', 'W.B.C.', 'NEUTROPHILS', 'LYMPHOCYTES', 'EOSINOPHILS',
      'MONOCYTES', 'BASOPHILS', 'PLATELETS'
    ];

    // Define regex patterns for extracting values
    final Map<String, String> attributePatterns = {
      'HAEMOGLOBIN': r'([\d+\.\d+]+)\s+g/dl',
      'HAEMATOCRIT': r'([\d+\.\d+]+)\s+%',
      'R.B.C.': r'([\d\.]+)\s+x10E12/L',
      'M.C.V.': r'([\d\.]+)\s+fL',
      'M.C.H.': r'([\d\.]+)\s+pg',
      'M.C.H.C.': r'([\d\.]+)\s+g/dL',
      'W.B.C.': r'([\d\.]+)\s+x10E9/L',
      'NEUTROPHILS': r'([\d\.]+)\s+%',
      'LYMPHOCYTES': r'([\d\.]+)\s+%',
      'EOSINOPHILS': r'([\d\.]+)\s+%',
      'MONOCYTES': r'([\d\.]+)\s+%',
      'BASOPHILS': r'([\d\.]+)\s+%',
      'PLATELETS': r'([\d\.]+)\s+x10E9/L'
    };

    // Variables to keep track of current attribute and value
    String currentAttribute = '';
    String currentValue = '';

    // List<String> lines = text.split('\n');
    List<String> lines = text.split('\n');
    Set<String> currentattribute_occurrence = {};
    
    for (String line in lines) {
      line = line.trim();
      print('line#####: $line');
      if (attributes.any((attr) => line.contains(attr))) {
        // Line contains an attribute
        for (String attribute in attributes) {
          if (line.contains(attribute)) {

            // if (!currentattribute_occurrence.contains(currentAttribute)){
            currentAttribute = attribute;
            print("FIRST IF STATEMENT******************");
            text = text.replaceAll(currentAttribute, '');

            currentattribute_occurrence.add(currentAttribute);
            break;
            // }
          }
        }
      }
      
      if (currentAttribute.isNotEmpty) {
        // Line contains the value for the current attribute
        final pattern = attributePatterns[currentAttribute];

        
        final match = RegExp(pattern!).firstMatch(text);
        print("SECOND IF STATEMENT******************");


        print(match);
        if (match != null) {
          currentValue = match.group(1)!.trim();
          print('VALUESSSSSSSSSSSSSSSSSSSSSSSSS***********************&&&&&&&: $currentValue');
          if (!matchedValues.contains(currentValue)){
            results[currentAttribute] = currentValue;
            matchedValues.add(currentValue);
            text = text.replaceFirst(currentValue, '');
            print('PARSED#############: $currentAttribute: $currentValue');  // Debug print
            currentAttribute = '';  // Reset current attribute
            print(matchedValues);
          } 
        }
      }
    }

  
    
    return results.entries.map((entry) => TestResult(entry.key, entry.value)).toList();
  }
}

class TestResult {
  final String attribute;
  final String value;

  TestResult(this.attribute, this.value);

  @override
  String toString() {
    return '$attribute: $value';
  }
}






// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:image_picker/image_picker.dart';

// class OcrService{
//   final ImagePicker _picker = ImagePicker();
//   final textDetector = GoogleMlKit.vision.textRecognizer();

//   Future<XFile?> pickImage(ImageSource source) async{
//     return await _picker.pickImage(source: source);
//   }

//   Future<String> extractTextFromImage(XFile image) async{
//     final inputImage = InputImage.fromFilePath(image.path);
//     final RecognizedText recognizedText = await textDetector.processImage(inputImage);
//     await textDetector.close();

//     return recognizedText.text;
//   }
// }