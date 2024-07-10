import '../models/testresults.dart';


// PROMPT CREATION FUNCTION TO BE USED IN MAIN HOMEPAGE WHERE DOCUMENT IS UPLOADED

String createPrompt(List<TestResult> testResults) {
  // Initialize a map to store the attributes and their values
  Map<String, String> attributes = {};

  // Populate the attributes map with values from testResults
  for (var result in testResults) {
    attributes[result.attribute] = result.value;
  }

  // Create the prompt string using the attributes from the map
  String prompt = "My cbc report says that my Hemoglobin is ${attributes['HB'] ?? 'N/A'} g/dL, "
                  "Hematocrit is ${attributes['HCT'] ?? 'N/A'}%, "
                  "RBC is ${attributes['RBC'] ?? 'N/A'} 10^6/uL, "
                  "MCV is ${attributes['MCV'] ?? 'N/A'} fL, "
                  "MCH is ${attributes['MCH'] ?? 'N/A'} pg, "
                  "MCHC is ${attributes['MCHC'] ?? 'N/A'} g/dL, "
                  "WBC is ${attributes['WBC'] ?? 'N/A'} 10^3/uL, "
                  "Neutrophils is ${attributes['NEUTROPHILS%'] ?? 'N/A'}%, "
                  "Lymphocytes is ${attributes['LYMPHOCYTES%'] ?? 'N/A'}%, "
                  "Monocytes is ${attributes['MONOCYTES%'] ?? 'N/A'}%, "
                  "Eosinophils is ${attributes['EOSINOPHILS%'] ?? 'N/A'}%, "
                  "Basophils is ${attributes['BASOPHILS%'] ?? 'N/A'}% and "
                  "Platelet Count is ${attributes['PLATELETS'] ?? 'N/A'} 10^3/uL. "
                  "Provide me a 4 line diagnosis with layman terms. Also create a heading Cure: and provide a 1 line cure";

  return prompt;
}

