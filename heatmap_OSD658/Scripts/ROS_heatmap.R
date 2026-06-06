library(readr)

file_path <- file.choose()

expr <- read.csv(
  file_path,
  check.names = FALSE
)

ros_genes <- c(
  "AT5G47910", # RBOHD
  "AT1G64060", # RBOHF
  "AT1G07890", # APX1
  "AT3G09640", # APX2
  "AT4G35090", # CAT2
  "AT1G20620", # CAT1
  "AT5G59820", # ZAT12
  "AT3G25250"  # OXI1
)

ros_labels <- c(
  "RBOHD",
  "RBOHF",
  "APX1",
  "APX2",
  "CAT2",
  "CAT1",
  "ZAT12",
  "OXI1"
)

ros_matrix <- expr[
  match(ros_genes, expr$TAIR),
  c(
    "TAIR",
    "Log2fc_(mixed radiation & 40 centigray)v(non-irradiated & nan Not Applicable)",
    "Log2fc_(mixed radiation & 80 centigray)v(non-irradiated & nan Not Applicable)"
  )
]

ros_matrix$Label <- paste0(
  ros_labels,
  " (",
  ros_matrix$TAIR,
  ")"
)

ros_export <- ros_matrix[, c(
  "Label",
  "Log2fc_(mixed radiation & 40 centigray)v(non-irradiated & nan Not Applicable)",
  "Log2fc_(mixed radiation & 80 centigray)v(non-irradiated & nan Not Applicable)"
)]

colnames(ros_export) <- c(
  "Label",
  "GCR_40cGy",
  "GCR_80cGy"
)

write.csv(
  ros_export,
  "GCR_ROS_Morpheus.csv",
  row.names = FALSE
)
