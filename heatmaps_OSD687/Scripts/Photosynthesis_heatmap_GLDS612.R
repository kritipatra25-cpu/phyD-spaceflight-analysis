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
photo_genes <- c(
  "ATCG00280",
  "ATCG00270",
  "ATCG00020",
  "ATCG00680",
  "ATCG00490",
  "AT2G05100",
  "AT1G29920",
  "AT1G29910",
  "AT3G27690",
  "AT5G54270",
  "AT2G05070",
  "AT1G67090",
  "AT5G38430"
)

photo_labels <- c(
  "ATCG00280 | PSBC",
  "ATCG00270 | PSBD",
  "ATCG00020 | PSBA",
  "ATCG00680 | PSBB",
  "ATCG00490 | RBCL",
  "AT2G05100 | LHCB2.1",
  "AT1G29920 | LHCB1.1",
  "AT1G29910 | LHCB1.2",
  "AT3G27690 | LHCB2.3",
  "AT5G54270 | LHCB3",
  "AT2G05070 | LHCB2.2",
  "AT1G67090 | RBCS1A",
  "AT5G38430 | RBCS1B"
)
photo_matrix <- expr[
  match(photo_genes, expr$TAIR),
  c("TAIR", sample_cols)
]

photo_matrix$GeneLabel <- photo_labels

photo_matrix <- photo_matrix[
  ,
  c("GeneLabel", sample_cols)
]

write.csv(
  ros_matrix,
  "results/GLDS612_Photosynthesis.csv",
  row.names = FALSE
)
