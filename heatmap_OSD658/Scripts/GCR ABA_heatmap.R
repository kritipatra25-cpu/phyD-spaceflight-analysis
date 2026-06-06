library(readr)

# Select OSD-658 file manually
expr <- read.csv(file.choose())

# Correct ABA genes
aba_genes <- c(
  "AT3G14440",  # NCED3
  "AT1G30100",  # NCED5
  "AT4G26080",  # ABI1
  "AT5G57050",  # ABI2
  "AT5G05440",  # PYL5
  "AT5G53160",  # PYL8
  "AT3G50500",  # SnRK2.2
  "AT5G66880",  # SnRK2.3
  "AT2G36270"   # ABI5
)

aba_labels <- c(
  "NCED3 (AT3G14440)",
  "NCED5 (AT1G30100)",
  "ABI1 (AT4G26080)",
  "ABI2 (AT5G57050)",
  "PYL5 (AT5G05440)",
  "PYL8 (AT5G53160)",
  "SnRK2.2 (AT3G50500)",
  "SnRK2.3 (AT5G66880)",
  "ABI5 (AT2G36270)"
)

aba_matrix <- expr[
  match(aba_genes, expr$TAIR),
  c(
    "Log2fc_(mixed radiation & 40 centigray)v(non-irradiated & nan Not Applicable)",
    "Log2fc_(mixed radiation & 80 centigray)v(non-irradiated & nan Not Applicable)"
  )
]

aba_export <- data.frame(
  id = aba_labels,
  GCR_40cGy = aba_matrix[,1],
  GCR_80cGy = aba_matrix[,2]
)

write.csv(
  aba_export,
  "GCR_ABA_Morpheus.csv",
  row.names = FALSE,
  quote = FALSE
)

print(aba_export)
