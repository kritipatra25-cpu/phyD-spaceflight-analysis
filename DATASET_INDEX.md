# Dataset Index

This investigation utilizes the following datasets:

| ID | Stressor | Tissue | Source |
|---|---|---|---|
| OSD-120 | Microgravity | Root | [NASA GeneLab](https://osdr.nasa.gov/bio/repo/data/studies/OSD-120) |
| OSD-678 | Microgravity | Shoot | [NASA GeneLab](https://osdr.nasa.gov/bio/repo/data/studies/OSD-678) |
| OSD-658 | GCR | Seedling | [NASA GeneLab](https://osdr.nasa.gov/bio/repo/data/studies/OSD-658) |
| NMF | Null Magnetic Field | Root/Shoot | [Maffei et al. (2022)](https://www.mdpi.com/2218-273X/12/12/1824) |

## Processed Tables
Final processed tables used for the Biomni integration are located in `Biomni/tables/`.
Key tables:
* `pathway_scores_OSD_meanlog2fc.csv`: Aggregated pathway scores across spaceflight conditions.
* `inter_module_edge_counts.csv`: Network interaction statistics.
* `testable_hypotheses_ranked.csv`: Mechanistic predictions derived from the synthesis.
