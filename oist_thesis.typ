#import "@preview/grayness:0.1.0": transparent-image

// Document mode flag
#let final-mode = state("final-mode", false)

// Thesis metadata states
#let thesis-title = state("thesis-title", "")
#let thesis-author = state("thesis-author", "")
#let thesis-submission-date = state("thesis-submission-date", "")

// Page header function
#let page_header = context {
  let is_final = final-mode.get()
  let current_page = counter(page).get().first()
  let chapter_query = query(selector(heading.where(level: 1)).before(here()))
  
  // Get chapter information
  if chapter_query.len() > 0 {
    let chapter = chapter_query.last()
    let chapter_title = chapter.body
    
    // Get section information for final mode
    let section_query = query(selector(heading.where(level: 2)).before(here()))
    let section_title = if section_query.len() > 0 { section_query.last().body } else { none }
    
    let is_even = calc.rem(current_page, 2) == 0
    
    set text(size: 10pt, weight: "bold")
    
    if is_final {
      // Submission mode: different headers for even/odd pages (two-sided)
      if is_even {
        // Even pages (left): chapter on right, page on left
        grid(
          columns: (auto, 1fr),
          align(left, str(current_page)),
          align(right, chapter_title)
        )
      } else {
        // Odd pages (right): section on left, page on right
        grid(
          columns: (1fr, auto),
          align(left, if section_title != none { section_title } else { "" }),
          align(right, str(current_page))
        )
      }
    } else {
      // Draft mode: chapter on left, page on right (one-sided)
      grid(
        columns: (1fr, auto),
        align(left, chapter_title),
        align(right, str(current_page))
      )
    }
  } else {
    // No chapter yet, just show page number
    align(right, str(current_page))
  }
}

// Title page function
#let title_page(title, author, supervisor, cosupervisor, submission_date) = {
  // Set Computer Modern Roman font for title page (CMU Serif is the Typst equivalent)
  set text(font: "CMU Serif", size: 12pt)
  
  set page(
    header: none,
    footer: none,
    background: [
      #place(
        center + horizon,
        block(
          width: 100%,
          height: 100%,
          [
            #move(
              dx: -8.8cm, // Adjusted offset for better centering
              dy: 5.5cm,
              transparent-image(
                read("images/symbol.jpg", encoding: none), 
                width: 100%, // Full page width
                alpha: 100% // More transparent for watermark effect
              )
            )
          ]
        )
      )
    ]
  )
  
  align(center, {
    // Reduce top space to move elements higher
    v(0.3fr)
    
    // University name in small caps (scshape equivalent)
    text(size: 14.4pt)[
      #smallcaps[Okinawa Institute of Science and Technology]\
      #smallcaps[Graduate University]
    ]
    v(0.4cm)
    
    // Degree text (large = 14.4pt in LaTeX)
    text(size: 14.4pt, "Thesis submitted for the degree")
    v(0.4cm)
    
    // Degree type (Large = 17.28pt in LaTeX)
    text(size: 17.28pt, "Doctor of Philosophy")
    v(0.4cm)
    
    // Top line
    line(length: 100%, stroke: 1.5pt)
    v(-0.5cm)
    
    // Title (huge = 24.88pt in LaTeX)
    text(size: 24.88pt, weight: "bold", title)
    v(-0.5cm)
    
    // Bottom line
    line(length: 100%, stroke: 1.5pt)
    v(2.5cm)
    
    // Author section
    align(right, text(size: 12pt, "by"))
    v(1cm)
    align(right, text(size: 14.4pt, weight: "bold", author))
    
    // Increase bottom space to compensate
    v(4.0fr)
    
    // Supervisor section
    align(right, [
      #text(size: 14.4pt, "Supervisor: ")
      #text(size: 14.4pt, weight: "bold", supervisor)
    ])
    
    // Co-supervisor if exists
    if cosupervisor != none {
      v(0cm) // No extra space between supervisor and co-supervisor
      align(right, [
        #text(size: 14.4pt, "Co-Supervisor: ")
        #text(size: 14.4pt, weight: "bold", cosupervisor)
      ])
    }
    
    v(1cm)
    align(right, text(size: 12pt, submission_date))
  })
  
  pagebreak()
}

// Appendix function
#let appendix(body) = {
  counter(heading).update(0)
  set heading(numbering: "A.1")
  body
}

// Main thesis function
#let thesis(title: "", author: "", supervisor: "", cosupervisor: none, submission_date: "", mode: "draft", body) = {
  // Set document metadata
  set document(title: title, author: author)
  
  // Update final mode state
  final-mode.update(mode == "submission")
  
  // Update thesis metadata states
  thesis-title.update(title)
  thesis-author.update(author)
  thesis-submission-date.update(submission_date)
  
  // Set base font (Times New Roman or similar)
  set text(font: "Times New Roman", lang: "en", size: 12pt)
  
  // Configure list settings to match LaTeX itemize
  set list(
    indent: 2em,
    body-indent: 0.5em,
    marker: ([•], [--], [◦], [·]),  // Bullet styles for nested lists
  )
  
  // Configure page settings based on mode
  if mode == "submission" {
    // Submission version: two-sided layout
    set page(
      paper: "a4",
      margin: (left: 3.0cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
      header-ascent: 0.6cm,
      footer-descent: 2pt
    )
  } else {
    // Draft version: one-sided layout
    set page(
      paper: "a4",
      margin: (left: 3.0cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
      header-ascent: 0.6cm,
      footer-descent: 2pt
    )
  }
  
  // Configure heading numbering
  set heading(numbering: "1.1")
  
  // Configure figure and table captions
  set figure.caption(separator: ": ")
  
  // Style figure captions with sans-serif font (Helvetica)
  show figure.caption: it => {
    // Use Helvetica (sans-serif) at 10pt
    set text(font: "Helvetica", size: 10pt)
    set align(left)
    
    // Determine if it's a figure or table
    let fig = query(figure).find(f => f.caption == it)
    
    if fig != none {
      context {
        if fig.body.func() == image {
          // Figure caption
          [*Figure #fig.counter.display(fig.numbering)*#it.separator#it.body]
        } else if fig.body.func() == table {
          // Table caption
          [*Table #fig.counter.display(fig.numbering)*#it.separator#it.body]
        } else {
          // Other caption
          [*#fig.supplement #fig.counter.display(fig.numbering)*#it.separator#it.body]
        }
      }
    } else {
      it
    }
  }
  
  // Configure figure and table numbering (chapter.number format)
  set figure(numbering: it => {
    let chap = counter(heading).get().at(0, default: 1)
    numbering("1.1", chap, it)
  })
  
  // Configure equation numbering
  set math.equation(numbering: "(1)")
  
  // Configure bibliography style
  set bibliography(style: "ieee", title: "Bibliography")
  
  // Configure cite style to match natbib square brackets
  show cite: it => {
    set text(weight: "regular")
    it
  }
  
  // Apply mode-specific spacing using show rule (recommended approach)
  show: body => {
    if mode == "submission" {
      // Single spacing for submission version
      set par(
        leading: 0.65em,
        spacing: 0.65em,
        first-line-indent: 1.5em,
        justify: true
      )
      
      // Apply list spacing for submission mode
      show list: it => {
        set par(leading: 0.65em, spacing: 0.65em)
        it
      }
      
      // Style chapter headings (level 1) for submission mode
      show heading.where(level: 1): it => {
        pagebreak(weak: true)
        v(2em)
        set text(size: 24.88pt, weight: "bold")
        block[
          #if it.numbering != none [
            Chapter #counter(heading).display(it.numbering)
            #linebreak()
          ]
          #it.body
        ]
        v(0.65em)
      }
      
      // Style section headings (level 2) for submission mode
      show heading.where(level: 2): it => {
        v(0.65em)
        set text(size: 17.28pt, weight: "bold")
        it
        v(0.65em)
      }
      
      // Style subsection headings (level 3) for submission mode
      show heading.where(level: 3): it => {
        v(0.65em)
        set text(size: 14.4pt, weight: "bold")
        it
        v(0.65em)
      }
      
      // Configure outline spacing for submission mode
      show outline: it => {
        set text(size: 12pt)
        set par(leading: 0.65em)
        it
      }
      
      body
    } else {
      // 1.5 spacing for draft version
      set par(
        leading: 1.2em,  // Increased leading for 1.5 line spacing
        spacing: 1.8em,  // Increased paragraph spacing
        first-line-indent: 1.5em,
        justify: true
      )
      
      // Apply increased spacing to all blocks
      set block(spacing: 1.8em)
      
      // Apply list spacing for draft mode
      show list: it => {
        set par(leading: 1.2em, spacing: 1.2em)
        set list(spacing: 1.2em)  // Space between list items
        it
      }
      
      // Style chapter headings (level 1) for draft mode
      show heading.where(level: 1): it => {
        pagebreak(weak: true)
        v(2em)
        set text(size: 24.88pt, weight: "bold")
        block[
          #if it.numbering != none [
            Chapter #counter(heading).display(it.numbering)
            #linebreak()
          ]
          #it.body
        ]
        v(1.8em)  // 1.5 line spacing after chapter
      }
      
      // Style section headings (level 2) for draft mode
      show heading.where(level: 2): it => {
        v(1.8em)
        set text(size: 17.28pt, weight: "bold")
        it
        v(1.8em)
      }
      
      // Style subsection headings (level 3) for draft mode
      show heading.where(level: 3): it => {
        v(1.8em)
        set text(size: 14.4pt, weight: "bold")
        it
        v(1.8em)
      }
      
      // Configure outline spacing for draft mode
      show outline: it => {
        set text(size: 12pt)
        set par(leading: 1.5em)
        it
      }
      
      body
    }
  }
  
  // Style outline entries - make chapter entries bold
  show outline.entry.where(level: 1): it => {
    text(weight: "bold", it)
  }
  
  // Title page
  title_page(title, author, supervisor, cosupervisor, submission_date)
  
  // Start front matter with roman numerals
  set page(
    numbering: "i",
    header: page_header
  )
  counter(page).update(1)
  
  body
}

// Helper function for numbered chapters
#let numbered-chapter(title, content) = [
  #heading(level: 1, numbering: "1.1", title)
  #content
]

// Helper function for unnumbered chapters
#let unnumbered-chapter(title) = {
  heading(level: 1, numbering: none, outlined: true, title)
}