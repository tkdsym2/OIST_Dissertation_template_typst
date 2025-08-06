#import "oist_thesis.typ": *

#show: doc => thesis(
  title: "Typst Dissertation Template",
  author: "Kazuma takada",
  supervisor: "S. Upervisor",
  cosupervisor: "C. O'Supervisor",
  submission_date: "August 2025",
  mode: "draft", // Change to "submission" for the final submission
  doc,
)

// ================================
// PREAMBLE SECTION
// ================================

// Front matter pages
#include "preamble/declaration.typ"
#include "preamble/abstract.typ"
#include "preamble/acknowledgments.typ"
#include "preamble/abbreviations.typ"
#include "preamble/glossary.typ"
#include "preamble/nomenclature.typ"
#include "preamble/dedication.typ"

// ================================
// LISTS AND CONTENTS
// ================================

// Table of Contents
#unnumbered-chapter("Table of Contents")
#v(2em)
#outline(
  title: none,
  depth: 3,
  indent: 2em,
)

// Add space before List of Figures
#v(2em)

// List of Figures
#unnumbered-chapter("List of Figures")
#v(2em)
#outline(
  title: none,
  target: figure.where(kind: image),
)

// Add space before List of Tables
#v(2em)

// List of Tables
#unnumbered-chapter("List of Tables")
#v(2em)
#outline(
  title: none,
  target: figure.where(kind: table),
)

// ================================
// MAIN TEXT
// ================================

// Switch to main content with headers but no bottom page numbers
#set page(numbering: none, header: page_header)
#counter(page).update(1)

// Main chapters
#include "chapters/introduction.typ"
#include "chapters/chapter1.typ"
#include "chapters/chapter2.typ"
#include "chapters/chapter3.typ"
#include "chapters/conclusion.typ"

// ================================
// BIBLIOGRAPHY
// ================================

#v(2em)
#unnumbered-chapter("Bibliography")
#bibliography("bibliography.bib", title: none)

// ================================
// APPENDICES
// ================================

#v(2em)
#unnumbered-chapter("Appendices")

// Table of Appendices
#v(1em)
#table(
  columns: (auto, 1fr, auto),
  stroke: none,
  align: (left, left, right),
  [*Appendix*], [*Title*], [*Page*],
  table.hline(),
  [A], [First Appendix], [#context {
    let targets = query(<appendix-a>)
    if targets.len() > 0 {
      counter(page).at(targets.first().location()).first()
    } else {
      "?"
    }
  }],
)

#pagebreak()

// Appendix content without chapter structure
#include "chapters/appendixA.typ"