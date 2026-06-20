# Project Structure

The repository is organized to follow the evolution of the systems biology investigation, from raw data processing to final integration.

## Root Directory
* `Biomni/`: Final integrated systems biology analysis and reports.
* `Data/`: Instructions and references for source datasets.
* `comparative_heatmap/`: Integration of spaceflight and NMF datasets.
* `heatmap_OSD120/`: Root microgravity analysis (OSD-120).
* `heatmaps_OSD678/`: Shoot microgravity analysis (OSD-678).
* `heatmap_OSD658/`: Galactic Cosmic Radiation analysis (OSD-658).
* `heatmaps_Null_Magnetic _Field/`: Null Magnetic Field analysis (Maffei et al.).
* `kegg_models/`: Pathway modeling using KEGG database.
* `sbgn_models/`: Mechanistic modeling using Systems Biology Graphical Notation (SBGN).
* `scripts/`: Shared SBGN processing pipelines.

## Folder Organization
Each analysis folder typically contains:
* `Scripts/`: R scripts for data processing and visualization.
* `Results/`: Generated heatmaps and CSV tables.
* `README.md`: Specific documentation for that analysis stage.
