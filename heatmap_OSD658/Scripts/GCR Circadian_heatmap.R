library(readr)

file_path <- file.choose()

expr <- read.csv(
  file_path,
  check.names = FALSE
)

circadian_genes <- c(
  "AT4G08920", # CRY1
  "AT1G04400", # CRY2
  "AT1G09570", # PHYA
  "AT2G18790", # PHYB
  "AT2G25930", # ELF3
  "AT2G40080", # ELF4
  "AT2G46790", # PRR9
  "AT2G46830", # CCA1
  "AT5G02810", # PRR7
  "AT5G24470", # PRR5
  "AT5G61380", # TOC1
  "AT1G01060"  # LHY
)

circadian_labels <- c(
  "CRY1",
  "CRY2",
  "PHYA",
  "PHYB",
  "ELF3",
  "ELF4",
  "PRR9",
  "CCA1",
  "PRR7",
  "PRR5",
  "TOC1",
  "LHY"
)

circadian_matrix <- expr[
  match(circadian_genes, expr$TAIR),
  c(
    "TAIR",
    "Log2fc_(mixed radiation & 40 centigray)v(non-irradiated & nan Not Applicable)",
    "Log2fc_(mixed radiation & 80 centigray)v(non-irradiated & nan Not Applicable)"
  )
]

circadian_matrix$Label <- paste0(
  circadian_labels,
  " (",
  circadian_matrix$TAIR,
  ")"
)

circadian_export <- circadian_matrix[, c(
  "Label",
  "Log2fc_(mixed radiation & 40 centigray)v(non-irradiated & nan Not Applicable)",
  "Log2fc_(mixed radiation & 80 centigray)v(non-irradiated & nan Not Applicable)"
)]

colnames(circadian_export) <- c(
  "Label",
  "GCR_40cGy",
  "GCR_80cGy"
)

write.csv(
  circadian_export,
  "GCR_Circadian_Morpheus.csv",
  row.names = FALSE
)
