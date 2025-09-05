setClass(
  "dVTableTree",
  slots = c(
    tbl = "VTableTree",
    titles = "character",
    footnotes = "character",
    usernotes = "character",
    paper = "character",
    width = "numeric"
  )
)

setClass(
  "dlisting",
  slots = c(
    lst = "listing_df",
    titles = "character",
    footnotes = "character",
    usernotes = "character",
    paper = "character",
    width = "numeric"
  )
)
