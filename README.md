# OIST Doctoral Thesis Typst Template

This is a Typst template for writing a doctoral thesis at the Okinawa Institute of Science and Technology (OIST).

## Prerequisites

Before you can use this template, you need to install Typst. You can find the installation instructions for your operating system on the official Typst website: [https://typst.app/docs/guide/install/](https://typst.app/docs/guide/install/)

## Usage

To compile the thesis, run the following command in your terminal:

```bash
typst compile main.typ
```

This will generate a PDF file named `main.pdf` in the same directory.

## Structure

- `main.typ`: The main file for your thesis. It imports all the necessary files and sets up the document structure.
- `oist_thesis.typ`: The core template file. It defines the `thesis` function, which sets up the title page, headers, and other document-wide settings.
- `chapters/`: This directory contains the individual chapters of your thesis. You can add, remove, or rename files in this directory as needed.
- `preamble/`: This directory contains the preamble files, such as the abstract, acknowledgments, and declaration.
- `images/`: This directory contains the images used in your thesis.
- `bibliography.bib`: The bibliography file for your thesis. You can add your own references to this file.

## Customization

To customize your thesis, you will need to edit the following files:

- `main.typ`: Change the `title`, `author`, `supervisor`, `cosupervisor`, and `submission_date` variables to match your own information.
- `chapters/`: Edit the files in this directory to write the content of your thesis.
- `preamble/`: Edit the files in this directory to add your own abstract, acknowledgments, and other preamble content.
- `bibliography.bib`: Add your own references to this file.
