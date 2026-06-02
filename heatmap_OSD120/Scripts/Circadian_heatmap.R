library(readr)

expr <- read.csv(
    "data/GLDS-120_rna_seq_differential_expression_rRNArm_GLbulkRNAseq.csv"
)

sample_cols <- grep(
    "Day13",
    colnames(expr),
    value = TRUE
)

circadian_genes <- c(
    "AT2G46830", # CCA1
    "AT1G01060", # LHY
    "AT5G61380", # TOC1
    "AT2G25930", # ELF3
    "AT2G40080", # ELF4
    "AT1G22770", # GI
    "AT5G24470", # PRR5
    "AT5G02810", # PRR7
    "AT2G46790", # PRR9
    "AT4G16250"  # LUX
)

circadian_labels <- c(
    "AT2G46830 | CCA1",
    "AT1G01060 | LHY",
    "AT5G61380 | TOC1",
    "AT2G25930 | ELF3",
    "AT2G40080 | ELF4",
    "AT1G22770 | GI",
    "AT5G24470 | PRR5",
    "AT5G02810 | PRR7",
    "AT2G46790 | PRR9",
    "AT4G16250 | LUX"
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
    "results/Circadian_Morpheus.csv",
    row.names = FALSE
)
