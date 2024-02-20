# %% - - - - - - - - - - - - - - - - - - - - - - -
from PIL import Image
import pytesseract
import pdf2image
import concurrent.futures
import threading
import time
import argparse
import os

# % - - - - - - - - - - - - - - - - - - - - - - -
# Utils

def pdf2txt_task(path, page, doc_texts):
    try:
        start_time = time.time()        

        # convert to image
        image = pdf2image.convert_from_path(path, 
            first_page = page - 1, last_page = page
        )[0]
        # extract text
        doc_texts[page] = pytesseract.image_to_string(image)

        end_time = time.time()
        elapsed_time = end_time - start_time
        
        print(f"Done! page: {page}, time: {elapsed_time:.2f} seconds.")
    except Exception as e: None

def threaded_OCR(path, page0, page1, nthreads):
    doc_texts = {}
    with concurrent.futures.ThreadPoolExecutor(max_workers=nthreads) as executor:
        futures = [
            executor.submit(pdf2txt_task, path, page, doc_texts) 
            for (th, page) in enumerate(range(page0, page1 + 3))
        ]
        for future in concurrent.futures.as_completed(futures):
            None
    return doc_texts

def write_txt(txt_path, doc_texts):
    pages = sorted(list(doc_texts.keys()))
    with open(txt_path, "w") as file:
        for page in pages:
            file.write("\n") 
            file.write(f"<<< {page} >>>\n") 
            file.write("\n") 
            file.write(doc_texts[page] + "\n") 

# %% - - - - - - - - - - - - - - - - - - - - - - -
def main():
    # CLI
    parser = argparse.ArgumentParser(description="Read a pdf and creates a txt file!")
    parser.add_argument('path', help='pdf file path')
    parser.add_argument('--page0', '-a', help='from page', default = 1, type = int)
    parser.add_argument('--page1', '-z', help='to page', default = 10000000, type = int)
    parser.add_argument('--nthreads', '-t', help='number of threads', default = 4, type = int)
    args = parser.parse_args()

    # extract args
    pdf_path = os.path.abspath(args.path)
    page0 = args.page0
    page1 = args.page1
    nthreads = args.nthreads
    pdfinfo = pdf2image.pdfinfo_from_path(pdf_path)
    page1 = min(pdfinfo['Pages'], page1)
    
    print("= = = = = = = = = = = = = = = = = = =")
    print(f"pdf_path: {pdf_path}")
    print(f"pages: {page0}-{page1}")
    print(f"nthreads: {nthreads}")

    # - - - - - - - - - - - - - - - - -
    # OCR
    print("= = = = = = = = = = = = = = = = = = =")
    print(f"READING PAGES")
    doc_texts = threaded_OCR(pdf_path, page0, page1, nthreads)

    # - - - - - - - - - - - - - - - - -
    # TXT
    txt_path = pdf_path + ".txt"   
    print("= = = = = = = = = = = = = = = = = = =")
    print(f"WRITING TXT")
    print(f"txt_path: {txt_path}")
    write_txt(txt_path, doc_texts)
    
    return 0


if __name__ == "__main__":
    main()


