library(readr)

expr <- read.csv(
  "data/GLDS612_expression.csv",
  check.names = FALSE
)

sample_cols <- grep(
  "bio_rep",
  colnames(expr),
  value = TRUE
)
photoresp_genes <- c(
  "AT1G36370",
  "AT4G33010",
  "AT4G37930",
  "AT1G11860",
  "AT3G14415",
  "AT2G13360",
  "AT3G14420",
  "AT1G23310",
  "AT1G68010",
  "AT5G09660"
)

photoresp_labels <- c(
  "AT1G36370 | SHM7",
  "AT4G33010 | GLDP1",
  "AT4G37930 | SHM1",
  "AT1G11860 | GLDT",
  "AT3G14415 | GOX2",
  "AT2G13360 | SGAT",
  "AT3G14420 | GOX1",
  "AT1G23310 | GGAT1",
  "AT1G68010 | HPR1",
  "AT5G09660 | PMDH1"
)
photoresp_matrix <- expr[
  match(photoresp_genes, expr$TAIR),
  c("TAIR", sample_cols)
]

photoresp_matrix$GeneLabel <- photoresp_labels

photoresp_matrix <- photoresp_matrix[
  ,
  c("GeneLabel", sample_cols)
]

write.csv(
  ros_matrix,
  "results/GLDS612_Photorespiration.csv",
  row.names = FALSE
)
