import PyPDF2
import sys

def extract_text_from_pdf(pdf_path):
    with open(pdf_path, 'rb') as file:
        reader = PyPDF2.PdfReader(file)
        text = ""
        for page_num in range(len(reader.pages)):
            page = reader.pages[page_num]
            text += page.extract_text()
        return text

def parse_cbc_report(text):
    attributes = {}
    lines = text.split('\n')

    for line in lines:
        if 'HB' in line:
            attributes['HB'] = line.split()[1]
        elif 'RBC' in line:
            attributes['RBC'] = line.split()[1]
        elif 'HCT' in line:
            attributes['HCT'] = line.split()[1]
        elif 'MCV' in line:
            attributes['MCV'] = line.split()[1]
        elif 'MCH' in line:
            attributes['MCH'] = line.split()[1]
        elif 'MCHC' in line:
            attributes['MCHC'] = line.split()[1]
        elif 'WBC' in line:
            attributes['WBC'] = line.split()[1]
        elif 'PLATELETS' in line:
            attributes['PLATELETS'] = line.split()[1]
        elif 'NEUTROPHILS%' in line:
            attributes['NEUTROPHILS%'] = line.split()[1]
        elif 'LYMPHOCYTES%' in line:
            attributes['LYMPHOCYTES%'] = line.split()[1]
        elif 'MONOCYTES%' in line:
            attributes['MONOCYTES%'] = line.split()[1]
        elif 'EOSINOPHILS%' in line:
            attributes['EOSINOPHILS%'] = line.split()[1]
        elif 'BASOPHILS%' in line:
            attributes['BASOPHILS%'] = line.split()[1]
        elif 'ESR' in line:
            attributes['ESR'] = line.split()[1]

    return attributes

def save_attributes_to_file(attributes, file_path):
    with open(file_path, 'w') as file:
        for key, value in attributes.items():
            file.write(f"{key}: {value}\n")

if __name__ == "__main__":
    pdf_path = sys.argv[1]
    # pdf_path = 'lib/controllers/DUHSReport.pdf'
    output_path = sys.argv[2]
    # output_path = 'lib/controllers/result.txt'
    text = extract_text_from_pdf(pdf_path)
    attributes = parse_cbc_report(text)
    save_attributes_to_file(attributes, output_path)
