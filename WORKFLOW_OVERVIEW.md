# Workflow Overview

This document describes the end-to-end analytical pipeline linking raw data to the final systems biology integration.

## 1. Data Acquisition
* **GeneLab**: OSD-120, OSD-678, OSD-658 (CSV)
* **NMF**: Maffei et al. Supplementary Excel (processed in `heatmaps_Null_Magnetic _Field/Scripts/`)

## 2. Module-Level Analysis
Differential expression is processed through pathway-specific filters to generate heatmaps:
* `heatmap_OSD120/Scripts/` → `heatmap_OSD120/Results/`
* `heatmaps_OSD678/Scripts/` → `heatmaps_OSD678/Results/`
* `heatmap_OSD658/Scripts/` → `heatmap_OSD658/Results/`

## 3. Pathway Modeling
Pathways are modeled using two standardized notations:
* **KEGG**: `kegg_models/Scripts/` (Pathview) → `kegg_models/OSD-120/` and `OSD-678/`
* **SBGN**: `scripts/SBGN_script/` → `sbgn_models/`

## 4. Systems Biology Integration (Biomni)
All previous results are integrated in the Biomni stage:
* **Input**: Aggregated CSVs in `Biomni/tables/`
* **Logic**: `Biomni/execution_trace/worker-0.ipynb`
* **Synthesis**: `Biomni/report_seed_germination_mechanism.md`
* **Visuals**: `Biomni/figures/` (e.g., `09_mechanistic_model.png`)
