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

ros_genes <- c(
  "AT1G64060",
  "AT1G20620",
  "AT1G07890",
  "AT1G08830",
  "AT5G47910",
  "AT3G10920",
  "AT4G35090",
  "AT1G20630",
  "AT4G25100",
  "AT3G09640"
)

ros_labels <- c(
  "AT1G64060 | RBOHF",
  "AT1G20620 | CAT1",
  "AT1G07890 | APX1",
  "AT1G08830 | CSD1",
  "AT5G47910 | RBOHD",
  "AT3G10920 | MSD1",
  "AT4G35090 | CAT2",
  "AT1G20630 | CAT3",
  "AT4G25100 | FSD1",
  "AT3G09640 | APX2"
)

ros_matrix <- expr[
  match(ros_genes, expr$TAIR),
  c("TAIR", sample_cols)
]

ros_matrix$GeneLabel <- ros_labels

ros_matrix <- ros_matrix[
  ,
  c("GeneLabel", sample_cols)
]

write.csv(
  ros_matrix,
  "results/GLDS612_ROS.csv",
  row.names = FALSE
)
