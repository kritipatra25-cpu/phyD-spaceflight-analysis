library(readr)

expr <- read.csv(
    "data/GLDS-120_rna_seq_differential_expression_rRNArm_GLbulkRNAseq.csv"
)

sample_cols <- grep(
    "Day13",
    colnames(expr),
    value = TRUE
)

ga_genes <- c(
    "AT4G25420",
    "AT5G51810",
    "AT1G80340",
    "AT1G78440",
    "AT1G15550",
    "AT1G30040",
    "AT3G63010",
    "AT3G05120",
    "AT5G27320",
    "AT1G14920"
)

ga_labels <- c(
    "AT4G25420 | GA20OX1",
    "AT5G51810 | GA20OX2",
    "AT1G80340 | GA3OX2",
    "AT1G78440 | GA20OX2",
    "AT1G15550 | GA3OX1",
    "AT1G30040 | GA20X1",
    "AT3G63010 | GID1B",
    "AT3G05120 | GID1A",
    "AT5G27320 | GID1C",
    "AT1G14920 | GAI"
)

ga_matrix <- expr[
    match(ga_genes, expr$TAIR),
    c("TAIR", sample_cols)
]

ga_matrix$GeneLabel <- ga_labels

ga_matrix <- ga_matrix[
    ,
    c("GeneLabel", sample_cols)
]

write.csv(
    ga_matrix,
    "results/Gibberellin_Morpheus.csv",
    row.names = FALSE
)
