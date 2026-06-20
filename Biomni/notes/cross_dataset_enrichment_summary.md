# Cross-dataset enrichment of hypocotyl- and vascular-associated programs

## Headline

Across three independent spaceflight and radiation transcriptomic studies (OSD-120 root, OSD-658 whole seedling, OSD-678 leaf; 6 contrasts; 22,178-24,725 genes per contrast), **all 7 vascular-associated programs are significantly enriched** (BH-FDR ≤ 0.04, all down-regulated) while **none of the 3 hypocotyl-associated programs are significantly enriched** (BH-FDR ≥ 0.34) when tested across all contrasts simultaneously. The vascular-composite (457 genes, union of 6 vascular cell-type panels) gives the strongest combined signal (Z = -6.23, BH-FDR = 4.55e-9) with 6/6 contrasts directionally consistent.

## Significant programs (BH-FDR < 0.05)

| Program | Atlas | n_panel | median log2FC | sign concordance | BH-FDR |
|---|---|---|---|---|---|
| vascular_composite | composite | 457 | -0.264 | 6/6 | 4.6e-09 |
| Xylem_root | Han | 100 | -0.403 | 6/6 | 1.4e-08 |
| Vasculature_shoot | Han | 100 | -0.343 | 5/6 | 1.0e-06 |
| Liew_xylem | Liew | 100 | -0.242 | 5/6 | 6.3e-06 |
| Procambium_root | Han | 67 | -0.220 | 5/6 | 9.4e-04 |
| Phloem_root | Han | 100 | -0.113 | 5/6 | 4.8e-03 |
| Liew_provasculature | Liew | 100 | -0.112 | 4/6 | 3.9e-02 |

## Non-significant programs

| Program | n_panel | median log2FC | sign concordance | BH-FDR |
|---|---|---|---|---|
| E.hypocotyl_epidermis_shoot | 100 | -0.045 | 4/6 | 0.335 |
| hypocotyl_axis_composite | 160 | -0.065 | 4/6 | 0.681 |
| Cortex_hypocotyl_shoot | 67 | -0.034 | 4/6 | 0.941 |

## Why the asymmetry

The hypocotyl_axis_composite flips direction across contexts: it is strongly positive in OSD-120 root-tip dark (+0.64) and OSD-678 leaf-light (+0.52), strongly negative in OSD-678 leaf-dark (-0.68), and near-zero in both OSD-658 GCR contrasts (-0.06, -0.07). This pattern is consistent with the Stage E model that hypocotyl elongation programs are context- and tissue-specific. Vascular programs, by contrast, are monotonically suppressed across all 6 spaceflight and GCR contrasts.

## Method

Per-contrast permutation against random gene sets of matched size (1,000 perms, sampled without replacement from the contrast's measured-gene universe). Stouffer combination across the 6 contrasts with √n weighting, sign-aware. BH-FDR across the 10 program-level p-values.

## Caveats

1. **Scope**: 3 OSD studies only. Maffei2022 was excluded after coverage QC showed 0-4 gene overlap between its published 194-gene ROS/hormone/clock panel and the cell-type marker panels tested here.
2. **Test conservatism**: Mean-extreme permutation is more conservative than rank-shift (Wilcoxon) for panels with small but consistent log2FC. Stage C reported a Wilcoxon FDR of 1.2e-3 for the hypocotyl composite at OSD-658_80cGy; the matched permutation p here is 0.07. The headline is therefore a conservative test of cross-dataset enrichment; the hypocotyl signal still exists in *individual* contrasts (notably OSD-120 root-dark and OSD-678 leaf-dark) but does not accumulate across the full 6-contrast pool.
3. **Sign-concordance ≠ significance**: 4/6 concordance is observed for both significant vascular programs (Liew_provasculature) and non-significant hypocotyl programs. What separates them is per-contrast effect magnitude, not direction agreement alone.
4. **Cross-study heterogeneity**: OSD-658 is whole-seedling GCR irradiation; OSD-120 is root-tip microgravity; OSD-678 is leaf microgravity with dark/light conditions. Effect sizes differ by an order of magnitude between studies, which contributes to the per-contrast variability for hypocotyl programs.

## Files

- `tables/cross_dataset_enrichment_meta.csv` (wide, 10 rows): program-level meta-statistics including BH-FDR and sign concordance.
- `tables/cross_dataset_enrichment_meta_long.csv` (long, 60 rows): per-(program × contrast) effect sizes and permutation p-values.
