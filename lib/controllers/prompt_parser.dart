import 'dart:core';

class CBCReportParser {
  final List<String> attributes = [
    'Hemoglobin',
    'Hematocrit',
    'RBC',
    'MCV',
    'MCH',
    'MCHC',
    'WBC',
    'Neutrophils',
    'Lymphocytes',
    'Monocytes',
    'Eosinophils',
    'Basophils',
    'Platelet'
  ];

  final List<String> units = [
    'g/dL',
    '%',
    'x10E12/L',
    'fL',
    'pg',
    'g/dL',
    'x10E9/L',
    '%',
    '%',
    '%',
    '%',
    '%',
    'x10E9/L'
  ];

  Map<String, String> parseValues(String extractedText) {
    List<String> lines = extractedText.split('\n').map((line) => line.trim()).toList();

    List<String> extractedAttributes = [];
    List<String> extractedValues = [];

    for (String line in lines) {
      if (attributes.contains(line)) {
        extractedAttributes.add(line);
      } else {
        RegExp regex = RegExp(r'\d+\.?\d*');
        if (regex.hasMatch(line)) {
          extractedValues.add(line);
        }
      }
    }

    Map<String, String> values = {};
    for (int i = 0; i < extractedAttributes.length; i++) {
      if (i < extractedValues.length) {
        values[extractedAttributes[i]] = extractedValues[i] + ' ' + units[attributes.indexOf(extractedAttributes[i])];
      }
    }

    for (String attribute in attributes) {
      values.putIfAbsent(attribute, () => 'Value not found');
    }

    return values;
  }

  String createPrompt(String extractedText) {
    Map<String, String> values = parseValues(extractedText);

    // Construct the prompt with attributes and their respective values
    String prompt = 'My CBC report says that ';
    for (int i = 0; i < attributes.length; i++) {
      if (values.containsKey(attributes[i])) {
        prompt += '${attributes[i]} is ${values[attributes[i]]}, ';
      }
    }
    prompt = prompt.trim();
    if (prompt.endsWith(',')) {
      prompt = prompt.substring(0, prompt.length - 1);
    }
    prompt += '. Provide me a 4 line diagnosis with laymen terms.';

    return prompt;
  }
}
