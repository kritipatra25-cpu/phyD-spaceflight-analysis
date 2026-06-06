library(readr)

file_path <- file.choose()

expr <- read.csv(
  file_path,
  check.names = FALSE
)

aba_genes <- c(
  "AT4G26080", # NCED3
  "AT3G14440", # NCED5
  "AT3G24220", # NCED9
  "AT1G52340", # PYL5
  "AT5G05440", # PYL8
  "AT4G26080", # ABI1
  "AT5G57050", # ABI2
  "AT3G11410", # ABI5
  "AT3G50500", # SnRK2.3
  "AT4G33950"  # SnRK2.2
)

aba_labels <- c(
  "NCED3",
  "NCED5",
  "NCED9",
  "PYL5",
  "PYL8",
  "ABI1",
  "ABI2",
  "ABI5",
  "SnRK2.3",
  "SnRK2.2"
)

aba_matrix <- expr[
  match(aba_genes, expr$TAIR),
  c(
    "TAIR",
    "Log2fc_(mixed radiation & 40 centigray)v(non-irradiated & nan Not Applicable)",
    "Log2fc_(mixed radiation & 80 centigray)v(non-irradiated & nan Not Applicable)"
  )
]

aba_matrix$Label <- paste0(
  aba_labels,
  " (",
  aba_matrix$TAIR,
  ")"
)

aba_export <- aba_matrix[, c(
  "Label",
  "Log2fc_(mixed radiation & 40 centigray)v(non-irradiated & nan Not Applicable)",
  "Log2fc_(mixed radiation & 80 centigray)v(non-irradiated & nan Not Applicable)"
)]

colnames(aba_export) <- c(
  "Label",
  "GCR_40cGy",
  "GCR_80cGy"
)

write.csv(
  aba_export,
  "GCR_ABA_Morpheus.csv",
  row.names = FALSE
)
