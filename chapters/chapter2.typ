= How to use the templates <ch-2>

This is a practical guide into how to use this template, by explaining the role of the different folders, and an option of `thesis(...mode)` property, which accepts either `draft` or `submission`.

#heading(level: 2, "Folders") // you can also write here "== Folders"

The main folder contains three folders detailed here:

- *images.* This folder should contain all the images that you will use in your thesis. It can contain subfolders, for example one for each chapter. To include an image from the main text, you can use the command `#figure(image("path/to/image.jpg", width: 30%))`. The path is relative to the main folder, so if you want to include an image from the images folder, you can write:
```typ
#figure(
  image("../images/chap3/emblem.jpg", width: 30%),
  caption: [Full caption with all the details here.font size has to be 10pt, and sentences has to be left side.],
) <fig-example>
```

- *chapters.* This folder contains a series of #raw("LaTeX") files that form the main text: introduction, chapters, conclusion, appendices and published articles. The introduction and conclusion as they are now are not numbered, which creates a few difficulties with the headers of the thesis. If you want the introduction and conclusion to be numbered, re-write and treat them as regular chapters. These text files are included in the main text of the thesis with the command `#include "chapters/filename.typ"` in the `./main.typ`. 
```typ
// main.typ
// Main chapters
#include "chapters/introduction.typ"
#include "chapters/chapter1.typ"
#include "chapters/chapter2.typ"
#include "chapters/chapter3.typ"
#include "chapters/conclusion.typ"
```

- *preamble.* This folder contains a series of typst files with the pages that will appear before the main text. Please write (or copy and paste) your own text in those files and delete the dummy text when appropriate. The files are:
  - `abbreviations.typ` --- List of abbreviations. If the list goes over one page, continue it as a new list on the next page.
  - `abstract.typ` --- Abstract. Follow directions in the file.
  - `acknowledgments.typ` --- Acknowledgments. Follow directions in the file.
  - `declaration.typ` --- Declaration of Original and Sole Authorship. Only modify the last item. This page needs to be signed once printed.
  - `dedication.typ` --- Dedication (optional). Should only be a very few lines.
  - `glossary.typ` --- Glossary (optional). If the list goes over one page, continue it as a new list on the next page.
  - `nomenclature.typ` --- Nomenclature (optional). If the list goes over one page, continue it as a new list on the next page.

== main.typ file

This is #strong[the main file], the only one that needs to be compiled to build the thesis. The thesis function is executed at the top of this file. When submitting to a graduate school, compile with the `mode` parameter set to `"draft"`.
```typ
#show: doc => thesis(
  title: "Typst Dissertation Template",
  author: "Kazuma takada",
  supervisor: "S. Upervisor",
  cosupervisor: "C. O'Supervisor",
  submission_date: "August 2025",
  mode: "draft",
  doc,
)
```
When you submit a temporary version to the graduate school, compile with `"submission"` parameter.

=== Page size, Margins, Spacing, Justification, and Pagination

These settings are all defined in `./oist_thesis.typ`. They should not be changed.

#set quote(block: true)
#quote(attribution: [OIST, Graduate School Policies#footnote[#link("https://www.oist.jp/education/policies-regulations/gs-policies")]])[
  _*Page size*: Theses are to be formatted to A4 page size._

  _*Margins*: The left margin should be 3 cm.  Top, right, and bottom margins should be 2.5 cm._

  _*Spacing*: Spacing should be 1.5 line spaced for examination and single spacing for final submission._

  _*Justification*: The main body of text left-right justified.  Titles should be left-justified.  Equation numbers should be right justified._

  _*Pagination*: Preliminary pages, ending before the main body of text, may be numbered sequentially using roman numerals.  The main body of text, beginning with the first page of the introduction, must be numbered sequentially, including figure pages and blank pages, starting at page number 1 for the first page of the introduction.  Arabic numerals are to be used._
]

#heading(level: 3, "Table of Contents, List of Figures, List of Tables") // you can also write here "=== Packages and other document configurations"

These settings are for displaying the outline of the chapters, tables, and figures that will appear in the paper. Basically, there is no need to change them.

=== Title Page

The title page is defined by the `#let title_page()` function in `./oist_thesis.typ`. Basically, there is no need to change it.

=== Preamble Pages

The page numbering settings are specified at the end of the `thesis()` function in `./oist_thesis.typ`. No changes are necessary.

=== Thesis Main Text

The main text is *Times New Roman 12pt*. This definition is specified as `set text(font: "Times New Roman", lang: "en", size: 12pt)` in the `thesis` function of `./oist_thesis.typ.` This is strictly defined in OIST policy as following.

#set quote(block: true)
#quote(attribution: [OIST, Graduate School Policies#footnote[#link("https://www.oist.jp/education/policies-regulations/gs-policies")]])[
  _*Font*: Times New Roman, 12-point font should be used for all main body text.  For graph legends, titles, image annotations, etc., Arial, Helvetica or Calibri, 10-point font, should be used for presentation clarity.  For headings, any font or size may be used for presentation and design considerations._
  
  ...
  
  _*Spelling*: American spelling._
]

=== Bibliography

References should be listed in bibliography.bib. Paste them in bibtex format. Please see the example below. When referencing literature in typst, write it as shown in `@Lee98`. This template uses APA style, but if you want to use another style such as IEEE, please change it in `./oist_thesis.typ`. If you want to cite multiple references side by side, please write them as shown in `@Fil09 @Muc10 @Lee98`. result will be a single reference @Lee98, multile references will be shown as @Fil09 @Muc10 @Lee98.

```bibtex
@article{Lee98,
	Author = {Lee, Hwang and Scully, Marlan},
	Issn = {0015-9018},
	Issue = {4},
	Journal = {Found. Phys.},
	Pages = {585-600},
	Publisher = {Springer Netherlands},
	Title = {The Physics of EIT and LWI in V-Type Configurations},
	Url = {http://dx.doi.org/10.1023/A:1018709621908},
	Volume = {28},
	Year = {1998}}
```
There are various citation styles, such as APA, Chicago, and IEEE. This template uses APA. If you want to change the citation style, change the `set bibliography(style: "apa", title: "Bibliography")` style parameter in `./oist_thesis.typ`.

#heading(level: 3, "Appendices") // you can also write here "=== Appendices"  

Structures the style for the appendices and builds them. The appendices are numbered with letters but are structured like regular chapters.

=== Published Articles

This last section add the PDF files of your previously published articles (or about to be published) to the thesis. You should only include PDF files provided by the publishing journal (*including preprint*). This is strictly for the examiners' convenience in the temporary bound thesis, as for copyright reasons these files may not be published in the final version of the thesis.

=== Differences between draft and submission modes

The `thesis(...mode)` property accepts either `draft` or `submission`. The `draft` mode is used for review, while the `submission` mode is used for the final version of the thesis.

The main difference is the spacing between lines. Therefore, it is likely that the appearance will differ from draft mode, so adjustments may be necessary before submission.

#set quote(block: true)
#quote(attribution: [OIST, Graduate School Policies#footnote[#link("https://www.oist.jp/education/policies-regulations/gs-policies")]])[
  _*Spacing*_ : Spacing should be 1.5 line spaced for examination and single spacing for final submission.
]
