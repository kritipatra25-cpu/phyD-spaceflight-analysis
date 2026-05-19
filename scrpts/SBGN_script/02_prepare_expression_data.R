#################################################
# 02_prepare_expression_data.R
# Create expression dataset
#################################################

library(tidyverse)
library(org.At.tair.db)
library(AnnotationDbi)

expr <- data.frame(

    gene = c(
        "AT2G18790",
        "AT1G01060",
        "AT5G61380",
        "AT5G59570",
        "AT3G54890",
        "AT5G13930"
    ),

    WT_Ground_ZT0 = c(
        1.2,
        -0.5,
        0.8,
        -1.5,
        2.0,
        0.6
    ),

    WT_Space_ZT0 = c(
        3.5,
        1.1,
        -1.2,
        -2.2,
        3.4,
        2.1
    ),

    phyD_Ground_ZT0 = c(
        0.4,
        -1.5,
        2.3,
        -0.7,
        1.2,
        -0.2
    ),

    phyD_Space_ZT0 = c(
        4.2,
        2.1,
        -2.4,
        -3.1,
        4.5,
        3.0
    )

)

genes <- expr$gene

mapped_ids <- mapIds(

    org.At.tair.db,

    keys = genes,

    column = "ENTREZID",

    keytype = "TAIR",

    multiVals = "first"
)

rownames(expr) <- mapped_ids

expr <- expr[!is.na(rownames(expr)), ]

write.csv(
    expr,
    "data/expression_data.csv"
)

cat("Expression dataset saved.\n")
