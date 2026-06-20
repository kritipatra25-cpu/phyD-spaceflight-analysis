# Naming Standardization Plan

This document identifies naming inconsistencies and provides a low-risk plan for standardization prior to archival.

## 1. Identified Inconsistencies

### Folder Pluralization
* `heatmap_OSD120` vs `heatmaps_OSD678`
* `heatmap_OSD658`
* `heatmaps_Null_Magnetic _Field`
* `sbgn_models` vs `kegg_models` (Consistent)

**Recommendation:** Standardize all "heatmap" folders to the plural `heatmaps_` to match the model folders.

### Directory Name Spaces
* `heatmaps_Null_Magnetic _Field/` contains a trailing space in the middle of the name.
* `scripts/SBGN_ script` is an orphan file with a space.

**Recommendation:** Rename `heatmaps_Null_Magnetic _Field` to `heatmaps_Null_Magnetic_Field`.

### File Extensions
* Multiple files are missing `.R` or have a trailing `.` (e.g., `photosynthesis_pipeline.`).

**Recommendation:** Append `.R` to all identified R scripts.

## 2. Implementation Strategy

| Risk Level | Action | Recommended Tool |
|---|---|---|
| LOW | Rename `heatmaps_Null_Magnetic _Field` | `mv` |
| LOW | Append `.R` to truncated scripts | `mv` |
| MEDIUM | Standardize `heatmap_` to `heatmaps_` | `mv` + update READMEs |
| MEDIUM | Clean up "ghost" files | `rm` |

**Note:** In accordance with the "Preserve History" constraint, renames should be handled carefully to avoid breaking existing links in the documentation.
