# Reproducibility Guide

To reproduce the analyses in this repository, follow these steps:

## 1. Data Acquisition
Raw differential expression data must be downloaded from NASA GeneLab and supplementary publication files. Follow the instructions in `Data/README.md`.

## 2. Environment Setup
The analyses require R (version >= 4.0).
Required libraries:
* `tidyverse` (dplyr, readr, ggplot2)
* `pheatmap`
* `SBGNview`
* `pathview`
* `org.At.tair.db`
* `AnnotationDbi`

## 3. Path Configuration
Most scripts expect data files to be located in a `data/` subdirectory within their folder, or in the root `Data/` directory. Check the `REPRODUCIBILITY_AUDIT.md` for specific path issues.

## 4. Running Scripts
Scripts should be run from their respective folder to ensure relative paths resolve correctly.
Example:
```bash
cd heatmap_OSD120/Scripts
Rscript ROS_heatmap.R
```
