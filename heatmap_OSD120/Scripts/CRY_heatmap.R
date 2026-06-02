library(readr)

expr <- read.csv(
    "data/GLDS-120_rna_seq_differential_expression_rRNArm_GLbulkRNAseq.csv"
)

sample_cols <- grep(
    "Day13",
    colnames(expr),
    value = TRUE
)

cry_genes <- c(
    "AT4G08920", # CRY1
    "AT1G04400"  # CRY2
)

cry_labels <- c(
    "AT4G08920 | CRY1",
    "AT1G04400 | CRY2"
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
    "results/CRY_Morpheus.csv",
    row.names = FALSE
)
