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

circadian_genes <- c(
  "AT5G61380",
  "AT2G25930",
  "AT2G18790",
  "AT3G46640",
  "AT2G40080",
  "AT5G02810",
  "AT5G24470",
  "AT2G46790",
  "AT1G04400",
  "AT1G01060",
  "AT4G08920",
  "AT2G40180"
)

circadian_labels <- c(
  "AT5G61380 | TOC1",
  "AT2G25930 | GI",
  "AT2G18790 | CCA1",
  "AT3G46640 | LUX",
  "AT2G40080 | ELF3",
  "AT5G02810 | PRR7",
  "AT5G24470 | PRR5",
  "AT2G46790 | PRR9",
  "AT1G04400 | CRY2",
  "AT1G01060 | LHY",
  "AT4G08920 | CRY1",
  "AT2G40180 | ELF4"
)

circadian_matrix <- expr[
  match(circadian_genes, expr$TAIR),
  c("TAIR", sample_cols)
]

circadian_matrix$GeneLabel <- circadian_labels

circadian_matrix <- circadian_matrix[
  ,
  c("GeneLabel", sample_cols)
]

write.csv(
  circadian_matrix,
  "results/GLDS612_Circadian.csv",
  row.names = FALSE
)
