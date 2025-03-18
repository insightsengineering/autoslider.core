setClass(
  "dVTableTree",
  slots = c(
    tbl = "VTableTree",
    titles = "character",
    footnotes = "character",
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
    paper = "character",
    width = "numeric"
  )
)

# setClass(
#   "dgtsummary",
#   slots = c(
#     gtsummary = "gtsummary",
#     titles = "character",
#     footnotes = "character",
#     paper = "character"
#   )
# )
