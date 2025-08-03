#import "../oist_thesis.typ": unnumbered-chapter
#unnumbered-chapter("Nomenclature")

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
      $c$
    ],
    [
      #set text(size: 12pt, font: "Times New Roman")
      Speed of light ($2.99792458 times 10^8 "ms"^(-1)$)
    ],
    
    [
      #set text(size: 12pt, weight: "bold", font: "Times New Roman")
      $planck.reduce$
    ],
    [
      #set text(size: 12pt, font: "Times New Roman")
      Planck's constant ($6.62607015 times 10^(-34) "Js"$)
    ],

    [
      #set text(size: 12pt, weight: "bold", font: "Times New Roman")
      $k_B$
    ],
    [
      #set text(size: 12pt, font: "Times New Roman")
      Boltzmann constant ($1.380 658 times 10^(-23) "JK"^(-1)$)
    ],

    [
      #set text(size: 12pt, weight: "bold", font: "Times New Roman")
      $Z_0$
    ],
    [
      #set text(size: 12pt, font: "Times New Roman")
      Impedance of free space ($376.730313461 upright(Omega)$)
    ],

    [
      #set text(size: 12pt, weight: "bold", font: "Times New Roman")
      $mu_0$
    ],
    [
      #set text(size: 12pt, font: "Times New Roman")
      Permeability of free-space ($4 pi times 10^(-7) "Hm"^(-1)$)
    ],
  )
]