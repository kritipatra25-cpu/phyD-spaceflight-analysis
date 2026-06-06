library(readr)

file_path <- file.choose()

expr <- read.csv(
  file_path,
  check.names = FALSE
)

ga_genes <- c(
  "AT1G15550", # GA3OX1
  "AT5G07200", # GA20OX3
  "AT1G60980"  # GA20OX4
)

ga_labels <- c(
  "GA3OX1",
  "GA20OX3",
  "GA20OX4"
)

ga_matrix <- expr[
  match(ga_genes, expr$TAIR),
  c(
    "TAIR",
    "Log2fc_(mixed radiation & 40 centigray)v(non-irradiated & nan Not Applicable)",
    "Log2fc_(mixed radiation & 80 centigray)v(non-irradiated & nan Not Applicable)"
  )
]

ga_matrix$Label <- paste0(
  ga_labels,
  " (",
  ga_matrix$TAIR,
  ")"
)

ga_export <- ga_matrix[, c(
  "Label",
  "Log2fc_(mixed radiation & 40 centigray)v(non-irradiated & nan Not Applicable)",
  "Log2fc_(mixed radiation & 80 centigray)v(non-irradiated & nan Not Applicable)"
)]

colnames(ga_export) <- c(
  "Label",
  "GCR_40cGy",
  "GCR_80cGy"
)

write.csv(
  ga_export,
  "GCR_Gibberellin_Morpheus.csv",
  row.names = FALSE
)
