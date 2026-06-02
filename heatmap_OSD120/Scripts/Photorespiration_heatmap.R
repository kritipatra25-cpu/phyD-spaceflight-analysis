library(readr)

expr <- read.csv(
    "data/GLDS-120_rna_seq_differential_expression_rRNArm_GLbulkRNAseq.csv"
)

sample_cols <- grep(
    "Day13",
    colnames(expr),
    value = TRUE
)

photoresp_genes <- c(
    
    "AT3G14420", # GOX1
    "AT1G11860", # SHM1
    "AT1G11860", # GLDT
    "AT1G36370", # SHM7
    "AT3G14415", # GOX2
    "AT2G13360", # SGAT
    "AT1G23310", # GGAT1
    "AT1G68010", # HPR1
    "AT4G33010", # GLDP1
    "AT5G09660"  # PMDH1
)

photoresp_labels <- c(
    
    "AT3G14420 | GOX1",
    "AT1G11860 | SHM1",
    "AT1G11860 | GLDT",
    "AT1G36370 | SHM7",
    "AT3G14415 | GOX2",
    "AT2G13360 | SGAT",
    "AT1G23310 | GGAT1",
    "AT1G68010 | HPR1",
    "AT4G33010 | GLDP1",
    "AT5G09660 | PMDH1"
)

photoresp_matrix <- expr[
    
    match(photoresp_genes, expr$TAIR),
    
    c("TAIR", sample_cols)
]

photoresp_matrix$GeneLabel <- photoresp_labels

photoresp_matrix <- photoresp_matrix[
    
    ,
    
    c("GeneLabel", sample_cols)
]

write.csv(
    
    photoresp_matrix,
    
    "results/Photorespiration_Morpheus.csv",
    
    row.names = FALSE
)
