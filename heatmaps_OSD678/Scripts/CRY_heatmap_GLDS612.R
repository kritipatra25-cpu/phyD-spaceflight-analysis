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

cry_genes <- c(
  "AT1G04400",
  "AT1G09530",
  "AT2G25930",
  "AT1G09570",
  "AT2G18790",
  "AT5G11260",
  "AT5G61380",
  "AT2G32950",
  "AT2G43010",
  "AT4G08920"
)

cry_labels <- c(
  "AT1G04400 | CRY2",
  "AT1G09530 | PAP3/PIF3/POC1",
  "AT2G25930 | ELF3",
  "AT1G09570 | PHYA",
  "AT2G18790 | PHYB",
  "AT5G11260 | HY5",
  "AT5G61380 | TOC1",
  "AT2G32950 | COP1",
  "AT2G43010 | SRL2",
  "AT4G08920 | CRY1"
)

cry_matrix <- expr[
  match(cry_genes, expr$TAIR),
  c("TAIR", sample_cols)
]

cry_matrix$GeneLabel <- cry_labels

cry_matrix <- cry_matrix[
  ,
  c("GeneLabel", sample_cols)
]

write.csv(
  cry_matrix,
  "results/GLDS612_CRY.csv",
  row.names = FALSE
)
