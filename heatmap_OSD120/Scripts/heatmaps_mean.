#################################################

# OSD-120 Mean Expression Heatmaps

# Spaceflight vs Ground Control

# Dataset:

# GLDS-120_rna_seq_differential_expression_

# rRNArm_GLbulkRNAseq.csv

# Comparison:

# Col-0 Light

# Ground Control vs Spaceflight


# Output:

# OSD120_Circadian_Mean.csv

# OSD120_ROS_Mean.csv

# OSD120_Gibberellin_Mean.csv

#################################################

library(dplyr)

#################################################

# Load Dataset

#################################################

expr <- read.csv(
file.choose()
)

#################################################

# Calculate Mean Expression

#################################################

expr$Ground_mean <- rowMeans(
expr[, c(
"Atha_Col.0_root_GC_Alight_Rep1_GSM2493759_Day13",
"Atha_Col.0_root_GC_Alight_Rep2_GSM2493760_Day13"
)],
na.rm = TRUE
)

expr$Flight_mean <- rowMeans(
expr[, c(
"Atha_Col.0_root_FLT_Alight_Rep1_GSM2493777_Day13",
"Atha_Col.0_root_FLT_Alight_Rep2_GSM2493778_Day13",
"Atha_Col.0_root_FLT_Alight_Rep3_GSM2493779_Day13"
)],
na.rm = TRUE
)

#################################################

# CIRCADIAN GENES

#################################################

circadian_ids <- c(
"AT4G08920",  # CRY1
"AT1G04400",  # CRY2
"AT1G09570",  # PHYA
"AT2G18790",  # PHYB
"AT2G25930",  # ELF3
"AT2G40080",  # ELF4
"AT2G46790",  # PRR9
"AT2G46830",  # CCA1
"AT5G02810",  # PRR7
"AT5G24470",  # PRR5
"AT5G61380",  # TOC1
"AT1G01060"   # LHY
)

circadian_data <- expr[
expr$TAIR %in% circadian_ids,
]

circadian_data$Gene <- c(
"LHY",
"CRY2",
"PHYA",
"PHYB",
"ELF3",
"ELF4",
"PRR9",
"CCA1",
"CRY1",
"PRR7",
"PRR5",
"TOC1"
)

circadian_export <- circadian_data[, c(
"Gene",
"TAIR",
"Ground_mean",
"Flight_mean"
)]

write.csv(
circadian_export,
"OSD120_Circadian_Mean.csv",
row.names = FALSE
)

#################################################

# ROS GENES

#################################################

ros_ids <- c(
"AT1G07890",  # APX1
"AT1G08830",  # SOD1
"AT1G12520",  # CCS
"AT1G20630",  # CAT1
"AT2G28190",  # SOD2
"AT3G09640",  # APX2
"AT4G25090",  # RBOHG
"AT5G51060",  # RBOHC
"AT5G60010"   # RBOHH
)

ros_data <- expr[
expr$TAIR %in% ros_ids,
]

ros_data$Gene <- c(
"APX1",
"SOD1",
"CCS",
"CAT1",
"SOD2",
"APX2",
"RBOHG",
"RBOHC",
"RBOHH"
)

ros_export <- ros_data[, c(
"Gene",
"TAIR",
"Ground_mean",
"Flight_mean"
)]

write.csv(
ros_export,
"OSD120_ROS_Mean.csv",
row.names = FALSE
)

#################################################

# GIBBERELLIN GENES

#################################################

ga_ids <- c(
"AT1G15550",  # GA3OX1
"AT1G60980",  # GA20OX4
"AT5G07200"   # GA20OX3
)

ga_data <- expr[
expr$TAIR %in% ga_ids,
]

ga_data$Gene <- c(
"GA3OX1",
"GA20OX4",
"GA20OX3"
)

ga_export <- ga_data[, c(
"Gene",
"TAIR",
"Ground_mean",
"Flight_mean"
)]

write.csv(
ga_export,
"OSD120_Gibberellin_Mean.csv",
row.names = FALSE
)

#################################################

# MORPHUS SETTINGS

#################################################

# Upload CSV to Morphus

# Rows = Gene

# Columns = Ground_mean, Flight_mean

# Cluster Rows = YES

# Cluster Columns = NO

# Transform = Row Z-score

# Color = Blue-White-Red

#################################################
