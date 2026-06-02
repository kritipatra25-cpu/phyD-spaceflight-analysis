library(readr)

expr <- read.csv(
    "data/GLDS-120_rna_seq_differential_expression_rRNArm_GLbulkRNAseq.csv"
)

sample_cols <- grep(
    "Day13",
    colnames(expr),
    value = TRUE
)

photosynthesis_genes <- c(
    "AT1G29910", # LHCB1.2
    "AT1G29920", # LHCB1.1
    "AT1G67090", # RBCS1A
    "AT2G05070", # LHCB2.2
    "AT2G05100", # LHCB2.1
    "AT3G27690", # LHCB2.3/2.4
    "AT5G38430", # RBCS1B
    "AT5G54270", # LHCB3
    "ATCG00020", # PSBA
    "ATCG00270", # PSBD
    "ATCG00280", # PSBC
    "ATCG00490", # RBCL
    "ATCG00680"  # PSBB
)

photosynthesis_labels <- c(
    "AT1G29910 | LHCB1.2",
    "AT1G29920 | LHCB1.1",
    "AT1G67090 | RBCS1A",
    "AT2G05070 | LHCB2.2",
    "AT2G05100 | LHCB2.1",
    "AT3G27690 | LHCB2.3/2.4",
    "AT5G38430 | RBCS1B",
    "AT5G54270 | LHCB3",
    "ATCG00020 | PSBA",
    "ATCG00270 | PSBD",
    "ATCG00280 | PSBC",
    "ATCG00490 | RBCL",
    "ATCG00680 | PSBB"
)

photosynthesis_matrix <- expr[
    match(photosynthesis_genes, expr$TAIR),
    c("TAIR", sample_cols)
]

photosynthesis_matrix$GeneLabel <- photosynthesis_labels

photosynthesis_matrix <- photosynthesis_matrix[
    ,
    c("GeneLabel", sample_cols)
]

write.csv(
    photosynthesis_matrix,
    "results/Photosynthesis_Morpheus.csv",
    row.names = FALSE
)
