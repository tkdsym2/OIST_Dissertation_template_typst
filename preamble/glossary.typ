#import "../oist_thesis.typ": unnumbered-chapter
#unnumbered-chapter("Glossary")

Please refer to the #link("https://groups.oist.jp/grad/academic-program-policies") for specifications.

Here is an example of how to write a glossary. You can use the following format:

#block(spacing: 1.5em)[
  #table(
    columns: (5.0cm, 1fr),
    align: (left, left),
    stroke: 0.8pt + gray.lighten(30%),
    inset: (x: 12pt, y: 10pt),
    
    // rows
    [
      #set text(size: 12pt, weight: "bold", font: "Times New Roman")
      Dipole Blockade
    ],
    [
      #set text(size: 12pt, font: "Times New Roman")
      Phenomenon in which the simultaneous excitation of two atoms is inhibited by their dipolar interaction.
    ],
    
    [
      #set text(size: 12pt, weight: "bold", font: "Times New Roman")
      Cavity Induced Transparency
    ],
    [
      #set text(size: 12pt, font: "Times New Roman")
      Phenomenon in which a cavity containing two atoms excited with light at a frequency halfway between the atomic frequencies contains the number of photons an empty cavity would contain.
    ],
  )
]