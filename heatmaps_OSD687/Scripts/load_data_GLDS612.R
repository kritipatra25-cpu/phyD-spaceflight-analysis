expr <- read.csv(
  "data/GLDS612_expression.csv",
  check.names = FALSE
)

sample_cols <- grep(
  "bio_rep",
  colnames(expr),
  value = TRUE
)

length(sample_cols)
