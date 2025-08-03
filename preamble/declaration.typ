#import "../oist_thesis.typ": unnumbered-chapter, thesis-title, thesis-author, thesis-submission-date

#unnumbered-chapter("Declaration of Original and Sole Authorship")

#context {
  let title = thesis-title.get()
  let author = thesis-author.get()
  let submission_date = thesis-submission-date.get()
  
  // Match LaTeX formatting for this page
  set par(
    justify: true,
    first-line-indent: 0em,  // No indentation for declaration page
    // Inherit line spacing from document settings (don't override)
  )
  
  [
    I, #author, declare that this thesis entitled #emph[#title] and the data presented in it are original and my own work.

    // Space between paragraphs should match line spacing
    
    I confirm that:
    
    #list(
      tight: false,  // Ensure proper spacing between list items
      [No part of this work has previously been submitted for a degree at this or any other university.],
      [References to the work of others have been clearly acknowledged. Quotations from the work of others have been clearly indicated, and attributed to them.],
      [In cases where others have contributed to part of this work, such contribution has been clearly acknowledged and distinguished from my own work.],
      [None of this work has been previously published elsewhere, with the exception of the following: (provide list of publications or presentations, or delete this part). (If the work of any co-authors appears in this thesis, authorization such as a release or signed waiver from all affected co-authors must be obtained prior to publishing the thesis. If so, attach copies of this authorization to your initial and final submitted versions, as a separate document for retention by the Graduate School, and indicate on this page that such authorization has been obtained).]
    )
    
    Date: #submission_date
    
    #v(0.5em)
    
    Signature: #h(2cm) 
    // Note: Add your signature image here. Place your signature image in the images/ directory
    // and uncomment the following line, replacing "signature.png" with your actual filename:
    // #image("../images/signature.png", width: 5cm)
  ]
}