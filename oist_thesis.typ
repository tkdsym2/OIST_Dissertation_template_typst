#import "@preview/grayness:0.1.0": transparent-image

// Document mode flag
#let final-mode = state("final-mode", false)

// Thesis metadata states
#let thesis-title = state("thesis-title", "")
#let thesis-author = state("thesis-author", "")
#let thesis-submission-date = state("thesis-submission-date", "")


// Page header function with underline
#let page_header = context {
  let is_final = final-mode.get()
  let current_page = counter(page).get().first()
  let chapter_query = query(selector(heading.where(level: 1)).before(here()))
  
  // check the current page for chapter heading
  let on_chapter_page = false
  let chapter_on_this_page = query(selector(heading.where(level: 1)).after(here()))
  if chapter_on_this_page.len() > 0 {
    // If there is a chapter heading on the current page
    let chapter_location = chapter_on_this_page.first().location()
    let current_location = here()
    // If they are on the same page
    if chapter_location.page() == current_location.page() {
      on_chapter_page = true
    }
  }

  // If this is the first page of a chapter, show only page number in upper right
  if on_chapter_page {
    set text(size: 10pt, weight: "bold", font: "Times New Roman")
    align(right, str(current_page))
    return
  }
  
  // Get chapter information
  if chapter_query.len() > 0 {
    let chapter = chapter_query.last()
    let chapter_title = chapter.body
    
    // Get section information for final mode
    let section_query = query(selector(heading.where(level: 2)).before(here()))
    let section_title = if section_query.len() > 0 { section_query.last().body } else { none }
    
    let is_even = calc.rem(current_page, 2) == 0
    
    set text(size: 10pt, weight: "bold", font: "Times New Roman")
    
    // Create header content
    let header_content = if is_final {
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
    
    // Add header content with underline
    block(below: 0.0em, spacing: 0pt)[
      #header_content
      #v(-1.5em)
      #line(length: 100%, stroke: 0.5pt)
    ]
  } else {
    // No chapter yet, just show page number with underline
    block(below: 0.0em, spacing: 0pt)[
      #align(right, str(current_page))
      #v(-1.5em)
      #line(length: 100%, stroke: 0.5pt)
    ]
  }
}

// Title page function
#let title_page(title, author, supervisor, cosupervisor, submission_date) = {
  // Set Times New Roman font for title page (instead of CMU Serif)
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
    
    // University name in small caps style (manual implementation)
    block(spacing: 0pt)[
      #set par(leading: 0.65em)  // Tight line spacing
      #text(size: 14.4pt)[
        #text(size: 14.4pt)[O]#text(size: 11.5pt)[KINAWA] 
        #text(size: 14.4pt)[I]#text(size: 11.5pt)[NSTITUTE] 
        #text(size: 11.5pt)[OF] 
        #text(size: 14.4pt)[S]#text(size: 11.5pt)[CIENCE] 
        #text(size: 14.4pt)[A]#text(size: 11.5pt)[ND] 
        #text(size: 14.4pt)[T]#text(size: 11.5pt)[ECHNOLOGY]\
        #text(size: 14.4pt)[G]#text(size: 11.5pt)[RADUATE] 
        #text(size: 14.4pt)[U]#text(size: 11.5pt)[NIVERSITY]
      ]
    ]
    v(1.0cm)
    
    // Degree text (large = 14.4pt in LaTeX)
    block(spacing: 0pt)[
      #set par(leading: 0.65em)  // Tight line spacing
      #text(size: 14.4pt, font: "CMU Serif", "Thesis submitted for the degree")
    ]
    v(1.0cm)
    
    // Degree type (Large = 17.28pt in LaTeX)
    block(spacing: 0pt)[
      #set par(leading: 0.65em)  // Tight line spacing
      #text(size: 17.28pt, font: "CMU Serif", "Doctor of Philosophy")
    ]
    v(1.0cm)
    
    // Top line
    block(spacing: 0pt)[
      #set par(leading: 0.65em)  // Tight line spacing
      #line(length: 100%, stroke: 1.2pt)
    ]
    v(0.5cm)
    
    // Title (huge = 24.88pt in LaTeX)
    block(spacing: 0pt)[
      #set par(leading: 0.65em)  // Tight line spacing
      #text(size: 24.88pt, font: "CMU Serif", title)
    ]
    v(0.5cm)
    
    // Bottom line
    block(spacing: 0pt)[
      #set par(leading: 0.65em)  // Tight line spacing
      #line(length: 100%, stroke: 1.2pt)
    ]
    v(2.5cm)
    
    // Author section
    align(right)[
      #block(spacing: 0pt)[
        #set par(leading: 0.65em)  // Tight line spacing
        #text(size: 12pt, font: "CMU Serif", "by")
        #v(0.2cm)
        #text(size: 14.4pt, weight: "bold", font: "CMU Serif", author)
      ]
    ]

    v(4.0fr)
    
    // Supervisor section
    align(right)[
      #block(spacing: 0pt)[
        #set par(leading: 0.65em)  // Tight line spacing
        #text(size: 14.4pt, font: "CMU Serif", "Supervisor: ")
        #text(size: 14.4pt, weight: "bold", font: "CMU Serif", supervisor)

        // Co-supervisor if exists
        #if cosupervisor != none {
          v(-1.0cm) // No extra space between supervisor and co-supervisor
          linebreak()
          text(size: 14.4pt, font: "CMU Serif", "Co-Supervisor: ")
          text(size: 14.4pt, weight: "bold", font: "CMU Serif", cosupervisor)
        }
        
        #v(1cm)
        #text(size: 12pt, font: "CMU Serif", submission_date)
      ]
    ]
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
  
  // Set base font (Times New Roman for primary text)
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
  
  // Style figure captions with Helvetica font (secondary font)
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
  
  // Configure table captions to appear above tables and align all captions to left
  show figure: it => {
    if it.body.func() == table {
      // For tables: place caption above the table with no spacing
      block(spacing: 1.0cm)[
        #block(
          spacing: 10pt,
          width: 100%
        )[
          #set align(left)
          #set text(font: "Helvetica", size: 10pt)
          #context {
            let fig = it
            [*Table #fig.counter.display(fig.numbering)*: #fig.caption.body]
          }
        ]
        #block(spacing: 10pt, it.body)
      ]
    } else {
      // For figures and other content: use default positioning (caption below) but left-aligned
      block[
        #it.body
        #block(width: 100%)[
          #set align(left)
          #set text(font: "Helvetica", size: 10pt)
          #context {
            let fig = it
            if fig.body.func() == image {
              [*Figure #fig.counter.display(fig.numbering)*: #fig.caption.body]
            } else {
              [*#fig.supplement #fig.counter.display(fig.numbering)*: #fig.caption.body]
            }
          }
        ]
      ]
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
  set bibliography(style: "apa", title: "Bibliography")
  
  // Configure cite style for APA format
  show cite: it => {
    set text(weight: "regular")
    it
  }
  
  // Style for code blocks and raw text (technical font)
  show raw: it => {
    set text(font: "CMU Typewriter Text", size: 12pt)
    if it.block {
      block(
        width: 100%,
        fill: luma(245),
        inset: 10pt,
        radius: 4pt,
        breakable: false,
        it
      )
    } else {
      it
    }
  }
  
  // Style for links
  show link: it => {
    set text(font: "CMU Sans Serif")
    underline(it)
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
        block[
          #if it.numbering != none [
            #set text(size: 24.88pt, weight: "bold", font: "Times New Roman")
            Chapter #counter(heading).display(it.numbering)
            #linebreak()
          ]
          #set text(size: 29.86pt, weight: "bold", font: "Times New Roman")
          #it.body
        ]
        v(0.65em)
      }
      
      // Style section headings (level 2) for submission mode
      show heading.where(level: 2): it => {
        v(0.65em)
        set text(size: 17.28pt, weight: "bold", font: "Times New Roman")
        it
        v(0.65em)
      }
      
      // Style subsection headings (level 3) for submission mode
      show heading.where(level: 3): it => {
        v(0.65em)
        set text(size: 14.4pt, weight: "bold", font: "Times New Roman")
        it
        v(0.65em)
      }
      
      // Configure outline spacing for submission mode
      show outline: it => {
        set text(size: 12pt, font: "Times New Roman")
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
        set par(first-line-indent: 0em)
        block(
          width: 100%,
          inset: (left: 0pt),
        )[
          #if it.numbering != none [
            #set text(size: 24.88pt, weight: "bold", font: "Times New Roman")
            #align(left)[Chapter #counter(heading).display(it.numbering)]
            #linebreak()
            #v(-2.0em)
          ]
          #set text(size: 24.88pt, weight: "bold", font: "Times New Roman")
          #align(left)[#it.body]
        ]
        v(1.8em)  // 1.5 line spacing after chapter
      }
      
      // Style section headings (level 2) for draft mode
      show heading.where(level: 2): it => {
        v(1.8em)
        set text(size: 17.28pt, weight: "bold", font: "Times New Roman")
        it
        v(1.8em)
      }
      
      // Style subsection headings (level 3) for draft mode
      show heading.where(level: 3): it => {
        v(1.8em)
        set text(size: 14.4pt, weight: "bold", font: "Times New Roman")
        it
        v(1.8em)
      }
      
      // Configure outline spacing for draft mode
      show outline: it => {
        set text(size: 12pt, font: "Times New Roman")
        set par(leading: 1.5em)
        it
      }
      
      body
    }
  }
  
  // Style outline entries - make chapter entries bold
  show outline.entry.where(level: 1): it => {
    text(weight: "bold", font: "Times New Roman", it)
  }

  // Style figure and table outline entries with thin font weight
  show outline.entry: it => {
    if it.element != none and it.element.func() == figure {
      text(weight: "regular", font: "Times New Roman", it)
    } else {
      it
    }
  }
  
  // Title page
  title_page(title, author, supervisor, cosupervisor, submission_date)
  
  // Start front matter with roman numerals (no header on preamble pages)
  set page(
    numbering: "i",
    header: none
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