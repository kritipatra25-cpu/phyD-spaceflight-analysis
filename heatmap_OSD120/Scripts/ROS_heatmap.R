library(readr)

expr <- read.csv(
    "data/GLDS-120_rna_seq_differential_expression_rRNArm_GLbulkRNAseq.csv"
)

sample_cols <- grep(
    "Day13",
    colnames(expr),
    value = TRUE
)

ros_genes <- c(
    "AT5G47910", # RBOHD
    "AT1G64060", # RBOHF
    "AT3G09640", # APX2
    "AT1G20620", # CAT1
    "AT4G35090", # CAT2
    "AT1G20630", # CAT3
    "AT1G07890", # APX1
    "AT1G08830", # CSD1
    "AT3G10920"  # MSD1
)

ros_labels <- c(
    "AT5G47910 | RBOHD",
    "AT1G64060 | RBOHF",
    "AT3G09640 | APX2",
    "AT1G20620 | CAT1",
    "AT4G35090 | CAT2",
    "AT1G20630 | CAT3",
    "AT1G07890 | APX1",
    "AT1G08830 | CSD1",
    "AT3G10920 | MSD1"
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
    "results/ROS_Morpheus.csv",
    row.names = FALSE
)
