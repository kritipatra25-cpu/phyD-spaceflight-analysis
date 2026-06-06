library(readr)

# Select OSD-658 file manually
file_path <- file.choose()

expr <- read.csv(
  file_path,
  check.names = FALSE
)

ga_genes <- c(
  "AT4G25420",  # GA20OX1
  "AT5G51810",  # GA20OX2
  "AT5G07200",  # GA20OX3
  "AT1G15550",  # GA3OX1

  "AT3G05120",  # GID1A
  "AT3G63010",  # GID1B
  "AT5G27320",  # GID1C
  "AT4G24210",  # SLY1

  "AT3G03450",  # RGL2
  "AT1G14920",  # GAI
  "AT2G01570"   # RGA
)

ga_labels <- c(
  "GA20OX1 (AT4G25420)",
  "GA20OX2 (AT5G51810)",
  "GA20OX3 (AT5G07200)",
  "GA3OX1 (AT1G15550)",

  "GID1A (AT3G05120)",
  "GID1B (AT3G63010)",
  "GID1C (AT5G27320)",
  "SLY1 (AT4G24210)",

  "RGL2 (AT3G03450)",
  "GAI (AT1G14920)",
  "RGA (AT2G01570)"
)

ga_matrix <- expr[
  match(ga_genes, expr$TAIR),
  c(
    "TAIR",
    "Log2fc_(mixed radiation & 40 centigray)v(non-irradiated & nan Not Applicable)",
    "Log2fc_(mixed radiation & 80 centigray)v(non-irradiated & nan Not Applicable)"
  )
]

colnames(ga_matrix) <- c(
  "TAIR",
  "GCR_40cGy",
  "GCR_80cGy"
)

ga_matrix$id <- ga_labels

ga_export <- ga_matrix[
  ,
  c(
    "id",
    "GCR_40cGy",
    "GCR_80cGy"
  )
]

write.csv(
  ga_export,
  "GCR_Gibberellin_Morpheus.csv",
  row.names = FALSE
)

print(ga_export)
