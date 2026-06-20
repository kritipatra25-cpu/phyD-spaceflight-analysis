# Reproducibility Audit

**Audit Date:** 2024-06-20
**Scope:** Repository-wide automated and manual script review.

## 1. Critical Issues

### Missing File Extensions
The following scripts are missing their `.R` extension, preventing them from being recognized or executed by standard tools:
* `scripts/SBGN_script/photosynthesis_pipeline.`
* `heatmap_OSD120/Scripts/heatmaps_mean.`
* `heatmaps_OSD678/Scripts/heatmap_mean`

### Broken Paths
Multiple scripts reference `data/` or `results/` subdirectories that may not exist in the repository or assume files are in the root:
* `heatmap_OSD120/Scripts/*.R`: Expects `data/GLDS-120_...csv`.
* `heatmaps_OSD678/Scripts/*.R`: Expects `data/GLDS612_expression.csv`.
* `kegg_models/Scripts/OSD-120/*`: Expects GeneLab CSVs in the working directory.

### Duplicate/Ghost Files
* `scripts/SBGN_ script`: Orphaned file with a space in the name.
* `heatmaps_Null_Magnetic _Field/Data/file`: Empty or placeholder file.

## 2. Dependency Audit
Required R packages detected:
* `tidyverse` (dplyr, readr)
* `pheatmap`
* `readxl`
* `SBGNview`
* `pathview`
* `org.At.tair.db`
* `AnnotationDbi`
* `xml2`
* `rsvg`

## 3. Recommendations
* **Fix extensions:** Rename truncated files to `.R`.
* **Standardize paths:** Use `file.path()` and consistent relative references to the root `Data/` folder.
* **Environment Specs:** Create an `renv.lock` or `environment.yml` to pin versions.
