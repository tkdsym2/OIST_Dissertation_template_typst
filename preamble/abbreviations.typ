#import "../oist_thesis.typ": unnumbered-chapter
#unnumbered-chapter("List of Abbreviations")

Please refer to the #link("https://groups.oist.jp/grad/academic-program-policies") for specifications.

Here is an example of how to write a list of abbreviations. You can use the following format:

#block(spacing: 1.5em)[
  #table(
    columns: (5.0cm, 1fr),
    align: (left, left),
    stroke: 0.8pt + gray.lighten(30%),
    inset: (x: 12pt, y: 10pt),
    
    // rows
    [
      #set text(size: 12pt, weight: "bold", font: "Times New Roman")
      OIST
    ],
    [
      #set text(size: 12pt, font: "Times New Roman")
      Okinawa Institute of Science and Technology
    ],
    
    [
      #set text(size: 12pt, weight: "bold", font: "Times New Roman")
      e.g.
    ],
    [
      #set text(size: 12pt, font: "Times New Roman")
      For example
    ],

    [
      #set text(size: 12pt, weight: "bold", font: "Times New Roman")
      etc.
    ],
    [
      #set text(size: 12pt, font: "Times New Roman")
      And so on
    ],

    [
      #set text(size: 12pt, weight: "bold", font: "Times New Roman")
      PPT
    ],
    [
      #set text(size: 12pt, font: "Times New Roman")
      positive partial transpose
    ],

    [
      #set text(size: 12pt, weight: "bold", font: "Times New Roman")
      SRPT
    ],
    [
      #set text(size: 12pt, font: "Times New Roman")
      Schrödinger-Robertson partial transpose
    ],
  )
]