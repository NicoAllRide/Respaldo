from PyPDF2 import PdfReader, PdfWriter

# Load the original PDF file
input_pdf = PdfReader("Cv-Nicolás-Bustamante.pdf")
output_pdf = PdfWriter()

# Iterate through each page in the original PDF
for page_num in range(len(input_pdf.pages)):
    page = input_pdf.pages[page_num]

    # Get the content of the page
    page_content = page.extract_text()

    # Create a new page with the same dimensions
    new_page = output_pdf.add_blank_page(width=page.mediabox.width, height=page.mediabox.height)

    # (Optional) Add a white rectangle to cover the original content
    new_page.merge_page(page)
    output_pdf.pages[page_num].merge_page(new_page)

# Save the new blank PDF
output_path = "blankPDFF.pdf"
with open(output_path, "wb") as output_file:
    output_pdf.write(output_file)

print(f"Blank PDF saved to {output_path}")
