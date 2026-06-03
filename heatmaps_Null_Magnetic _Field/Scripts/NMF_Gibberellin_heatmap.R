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

gene_names <- nmf[[2]][4:197]

# =====================================================
# Gibberellin genes
# =====================================================

ga_genes <- c(
  "GA20OX4, GIBBERELLIN 20-OXIDASE 4",
  "GA3OX1, GA4, GIBBERELLIN 3-OXIDASE 1",
  "GA20OX3, GIBBERELLIN 20-OXIDASE 3"
)

ga_idx <- which(gene_names %in% ga_genes)

ga_matrix <- as.matrix(expr[ga_idx, ])

rownames(ga_matrix) <- c(
  "GA20OX4",
  "GA3OX1",
  "GA20OX3"
)

# =====================================================
# Plot
# =====================================================

pheatmap(
  ga_matrix,
  scale = "row",
  cluster_rows = TRUE,
  cluster_cols = FALSE,
  angle_col = 90,
  fontsize_row = 12,
  fontsize_col = 12,
  main = "NMF Gibberellin Genes (Root/Shoot Time Series)"
)

# =====================================================
# Save
# =====================================================

png(
  "Results/NMF_Gibberellin_TimeSeries.png",
  width = 1800,
  height = 1000,
  res = 200
)

pheatmap(
  ga_matrix,
  scale = "row",
  cluster_rows = TRUE,
  cluster_cols = FALSE,
  angle_col = 90,
  fontsize_row = 12,
  fontsize_col = 12,
  main = "NMF Gibberellin Genes (Root/Shoot Time Series)"
)

dev.off()
