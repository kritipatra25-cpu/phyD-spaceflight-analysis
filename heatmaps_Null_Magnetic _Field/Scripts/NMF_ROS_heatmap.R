library(readxl)
library(pheatmap)

# =====================================================
# Load NMF Supplementary Dataset
# =====================================================

nmf <- read_excel(
  "Data/NMF_Supplementary_Table_S2.xlsx",
  col_names = FALSE
)

# =====================================================
# Extract expression matrix
# =====================================================

expr <- nmf[4:197, 7:20]

expr <- as.data.frame(expr)

expr[] <- lapply(expr, function(x){
  as.numeric(sub(" ±.*", "", x))
})

# =====================================================
# Time-series column names
# =====================================================

colnames(expr) <- c(
  "Root_10min",
  "Root_1h",
  "Root_2h",
  "Root_4h",
  "Root_24h",
  "Root_48h",
  "Root_96h",
  "Shoot_10min",
  "Shoot_1h",
  "Shoot_2h",
  "Shoot_4h",
  "Shoot_24h",
  "Shoot_48h",
  "Shoot_96h"
)

# =====================================================
# Gene names
# =====================================================

gene_names <- nmf[[2]][4:197]

# =====================================================
# ROS genes
# =====================================================

ros_genes <- c(
  "APX1, ASCORBATE PEROXIDASE 1",
  "SOD1, COPPER/ZINC SUPEROXIDE DISMUTASE 1",
  "CCS, COPPER CHAPERONE FOR SOD1",
  "CAT1, CATALASE 1",
  "SOD2, SUPEROXIDE DISMUTASE 2",
  "APX2, ASCORBATE PEROXIDASE 1B, ASCORBATE PEROXIDASE 2",
  "RBOHJ, RESPIRATORY BURST OXIDASE HOMOLOG J",
  "RBOHG",
  "RBOHC, RESPIRATORY BURST OXIDASE HOMOLOG C",
  "RBOHH, RESPIRATORY BURST OXIDASE HOMOLOG H"
)

ros_idx <- which(gene_names %in% ros_genes)

ros_matrix <- as.matrix(expr[ros_idx, ])

rownames(ros_matrix) <- c(
  "APX1",
  "SOD1",
  "CCS",
  "SOD2",
  "APX2",
  "RBOHG",
  "RBOHJ",
  "CAT1",
  "RBOHC",
  "RBOHH"
)

# =====================================================
# Plot
# =====================================================

pheatmap(
  ros_matrix,
  scale = "row",
  cluster_rows = TRUE,
  cluster_cols = FALSE,
  angle_col = 90,
  fontsize_row = 12,
  fontsize_col = 12,
  main = "NMF ROS Genes (Root/Shoot Time Series)"
)

# =====================================================
# Save
# =====================================================

png(
  "Results/NMF_ROS_TimeSeries.png",
  width = 1800,
  height = 1200,
  res = 200
)

pheatmap(
  ros_matrix,
  scale = "row",
  cluster_rows = TRUE,
  cluster_cols = FALSE,
  angle_col = 90,
  fontsize_row = 12,
  fontsize_col = 12,
  main = "NMF ROS Genes (Root/Shoot Time Series)"
)

dev.off()
