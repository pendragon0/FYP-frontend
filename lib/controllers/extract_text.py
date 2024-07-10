import pytesseract
from PIL import Image
import cv2
import numpy as np
import os

def preprocess_image(image):
    image = cv2.imread(image, cv2.IMREAD_GRAYSCALE)

    #Apply thresholding
    _, image = cv2.threshold(image, 150, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)

    image = cv2.medianBlur(image, 3)

    return image

def extract_text_from_image(image):

    #preprocessing the image
    final_image = preprocess_image(image)

    #convert image to a format compatible with PIL 
    pil_image = Image.fromarray(final_image)

    #using tesseract
    text = pytesseract.image_to_string(image)
    
    return text

def parse_cbc_report(text):
    attribute_mapping = {
        'HB': ['HB', 'HEMOGLOBIN', 'Hemoglobin', 'Haemoglobin', 'HAEMOGLOBIN'],
        'HCT': ['HCT', 'HEMATOCRIT', 'Hematocrit', 'HAEMATOCRIT'],
        'RBC': ['RBC', 'RED BLOOD CELLS', 'Red Blood Cells', 'Red blood cells','Red Cell Count'],
        'MCV': ['MCV','M.C.V', 'M.CV', 'MC.V'],
        'MCH': ['MCH','M.CH', 'MC.H','M.C.H'],
        'MCHC': ['MCHC','M.CH.C', 'MC.H.C','M.C.H.C','M.C.HC','MC.HC'],
        'WBC': ['WBC', 'WHITE BLOOD CELLS', 'White Blood Cells', 'White blood cells'],
        'PLATELETS': ['PLATELETS', 'PLATELET COUNT', 'Platelet Count', 'Platelet count'],
        'NEUTROPHILS%': ['NEUTROPHILS%', 'Neutrophils', 'NEUTROPHILS'],
        'LYMPHOCYTES%': ['LYMPHOCYTES%', 'Lymphocytes', 'LYMPHOCYTES'],
        'MONOCYTES%': ['MONOCYTES%', 'Monocytes', 'MONOCYTES'],
        'EOSINOPHILS%': ['EOSINOPHILS%', 'Eosinophils', 'EOSINOPHILS'],
        'BASOPHILS%': ['BASOPHILS%', 'Basophils', 'BASOPHILS'],
        'ESR': ['ESR']
    }

    attributes = {key: None for key in attribute_mapping}
    lines = text.split('\n')

    for line in lines:
        for key, synonyms in attribute_mapping.items():
            if any(synonym in line.upper() for synonym in synonyms):
                # Extract the numeric value from the line
                numeric_value = next((s for s in line.split() if s.replace('.', '', 1).replace(',', '', 1).isdigit()), None)
                if numeric_value:
                    attributes[key] = numeric_value
                break

    # Remove None values from attributes
    attributes = {k: v for k, v in attributes.items() if v is not None}

    return attributes

text = extract_text_from_image('projm\lib\controllers\scan report1.jpg')
print(text)
print(parse_cbc_report(text))