# PLAN — NMF-focused systems-biology synthesis with new Maffei2022 supplement

## 1. Summary

Build a synthesis layer on top of the existing Stage A–E artifacts that (a) **brings in the new Maffei2022 supplement** (cluster A–E temporal patterns, polyphenol panel, H2O2 panel) which Stage E lacked, (b) **tissue-organises** the existing pathway-activity scores into a five-tissue × four-stressor matrix labelling each module as activated/suppressed/rewired, and (c) **produces two PDFs** — a focused NMF report with a new NMF systems-biology figure, and an integrated all-stressor synthesis. No re-running of the OSD/Maffei differential expression, network construction, autoencoder, or cell-type enrichment — all of that exists on disk and is locked.

Stressors referenced: **µg** (OSD-120 root + OSD-678 leaf), **GCR** (OSD-658 whole-seedling 40 cGy + 80 cGy), **NMF** (Maffei2022 root + shoot, 7 timepoints).

Tier convention preserved from Stage E: T1 = data this study computed; T2 = atlas / network; T3 = literature; T4 = hypothesis with falsification.

## 2. Inputs (already on disk; read-only)

- **DE matrices.** `long_OSD_microgravity_GCR.csv.gz` (142,784 rows: OSD-120, OSD-678, OSD-658), `long_NMF_Maffei2022.csv.gz` (2,716 rows: 194 genes × 14 timepoint–tissue cells, log2-ratios precomputed).
- **Pathway scores.** `pathway_scores_all.csv` (620 rows = 31 pathways × 20 condition-cells, includes 14 NMF conditions).
- **Cell-type enrichment.** `celltype_enrichment_combined_Han_Liew.csv` (186 rows = 31 cell-type groups × 6 OSD conditions). **NMF cell-type enrichment is NOT included** and will not be retrofitted (Maffei 194-gene panel has 0–4 gene overlap with Han/Liew cell-type marker panels — known infeasibility from the prior cross-dataset session).
- **Cross-dataset meta.** `cross_dataset_enrichment_meta.csv` + `_long.csv` (OSD-only, 10 programs × 6 contrasts; vascular 7/7 significant, hypocotyl 0/3 — already established).
- **Network.** `seed_tissue_network_edges.csv`, `inter_module_edge_counts.csv` (3,944 hub-anchored |ρ|=1 edges across 7 modules).
- **New: Maffei supplement zip** at `/mnt/user-uploads/biomolecules-12-01824-s001.zip`, extracted to `/workspace/nmf_supp/`. Contents:
  - **S2**: 194 ROS/oxidative genes × 14 conditions with NMF/GMF mean ± SD + **cluster letter A–E** (89 of 194 genes assigned, 105 unassigned) + subcellular prediction. Used as the heatmap source by the user.
  - **S3**: H2O2 content Tukey HSD pairwise differences (8 conditions: GMF/NMF × shoot/root × 24h/48h/96h).
  - **S4**: 48 H2O2-producing-gene subset of S2, late timepoints only.
  - **S5**: HPLC polyphenol content per compound (~46 polyphenols) × GMF/NMF × shoot/root × 24h/48h/96h, mean (SD).
  - **S6**: Polyphenol Tukey HSD pairwise differences.
  - **S7**: 36 polyphenol-metabolism genes × GMF/NMF × shoot/root × 4h/24h/48h/96h, mean ± SD.

## 3. Outputs (new files, never overwrite existing)

```
/mnt/results/
  tables/
    nmf_cluster_profile.csv          # A–E cluster × tissue × time mean log2 ratio (5×14 = ~70 rows + cluster summary)
    nmf_cluster_membership.csv       # 194-gene panel with cluster letter, subcellular, gene_function
    nmf_polyphenol_gene_panel.csv    # S7-derived: 36 genes × shoot/root × 4h/24h/48h/96h log2 ratio
    nmf_polyphenol_content.csv       # S5-derived: polyphenol × tissue × time × {GMF,NMF} mean and Tukey-significance
    nmf_h2o2_panel.csv               # S4-derived: 44 H2O2 genes × tissue × late timepoints
    tissue_pathway_summary.csv       # 5 tissues × 4 stressors × 31 pathways: signed activity + activated/suppressed/rewired label
    integrated_stressor_matrix.csv   # the master mod × stressor × tissue activity table for the integrated figure
  figures/
    10_nmf_cluster_heatmap.png/.svg  # 5 clusters × 14 (tissue × time) heatmap, derived from S2 cluster letters
    11_nmf_polyphenol_summary.png/.svg  # polyphenol metabolism: gene panel + HPLC content side-by-side
    12_nmf_systems_biology.png/.svg  # the NMF causal-chain figure: NMF → magnetoreception → ROS-cluster + polyphenol → GA-biosynthesis → germination
    13_integrated_systems_biology.png/.svg  # multi-stressor systems biology: µg / GCR / NMF → cellular → tissue → metabolic → hormone → germination
  notes/
    nmf_supplement_analysis.md       # methods + headline numbers for the NMF zip analyses
  nmf_systems_biology_summary.pdf    # short PDF: NMF-focused, contains figure 12 + the cluster/polyphenol/H2O2 results
  integrated_systems_biology_report.pdf  # long PDF: re-bundles Stage E + new NMF chapters + figure 13
```

Locked / unchanged: `report_seed_germination_mechanism.md`, `figures/09_mechanistic_model.*`, all existing `tables/`.

## 4. Method — step by step

### 4.1 NMF supplement re-analysis (new)

**4.1.1 S2 cluster profile.** Parse "X ± Y" into mean only. Compute per-cluster (A/B/C/D/E) mean log2 ratio at each of the 14 (tissue × timepoint) cells. From the pilot inspection:
- A (n=33): shoot-induction-only.
- B (n=23): both-tissue constitutive induction (largest amplitude, ~+1.0).
- C (n=11): variable/transient.
- D (n=14): late induction in both.
- E (n=8): early sustained both.

Render as a 5 × 14 heatmap (Figure 10) with cluster labels and timepoints on the axes.

**4.1.2 Polyphenol panel (S7).** Compute mean log2 ratio per gene × condition for the 36 polyphenol metabolism genes, then per-class (chalcone synthase, flavonol synthase, dihydroflavonol reductase, MYB, UGT, etc.) summary scores by tissue × time. Identify the strongest single-gene direction-of-effect changes (e.g., MYB90 / PAP2 at +2.07 shoot 96h).

**4.1.3 Polyphenol content (S5/S6).** Aggregate HPLC content per compound class (flavonoid, anthocyanin, isoflavone, lignan, etc.) × tissue × time × {GMF,NMF}. Extract the Tukey HSD significance flags (*, **, ***) from S6 for the NMF-vs-GMF pairwise comparisons.

**4.1.4 H2O2 panel (S4) and content (S3).** Compute mean log2 ratio for the 44-gene H2O2-producing subset at 4h/24h/48h/96h × tissue. Tabulate the H2O2 content Tukey HSD results to anchor the protein-level vs transcript-level direction-of-effect tension (already flagged in Stage E §4 caveat: NMF transcript = ROS-up, NMF H2O2 protein = ROS-down).

**4.1.5 Hand off cluster A–E activity scores to the integrated table** as pseudo-pathways: `NMF_cluster_A` … `NMF_cluster_E`.

### 4.2 Tissue-stressor pathway-activity synthesis

**4.2.1 Tissue assignment of conditions.**

| Stressor | Condition | Tissue mapping (this study's logic) |
|---|---|---|
| µg | OSD-120 root_tip dark/light | **root** |
| µg | OSD-678 leaf dark/light | **shoot** (leaf-context) |
| GCR | OSD-658 whole_seedling 40/80 cGy | **whole-seedling** (proxy for "all"; no per-tissue resolution) |
| NMF | Maffei root 10min–96h | **root** |
| NMF | Maffei shoot 10min–96h | **shoot** |

Five target tissues *embryo, hypocotyl, root, shoot, vascular* are honestly addressable as:
- **root** — direct in OSD-120, Maffei
- **shoot** — direct in OSD-678, Maffei
- **vascular** — projected via cell-type enrichment (`Vasculature_shoot`, `Xylem_root`, `Phloem_root`, `Procambium_root`, `Liew_provasculature`, `Liew_xylem`) which exists for OSD only.
- **hypocotyl** — projected via cell-type enrichment (`Cortex_hypocotyl_shoot`, `E.hypocotyl_epidermis_shoot`) for OSD only.
- **embryo** — NOT directly resolvable from these datasets (none target embryonic tissue). Will be flagged as T3/T4 (literature) only.

**4.2.2 Activity labelling rules.** For each (tissue × stressor × pathway) cell:
- `mean_log2fc` from `pathway_scores_all.csv`, averaged over contrasts within that tissue/stressor.
- Label: **activated** if mean > +0.30 with consistent sign in ≥75% of contrasts; **suppressed** if mean < −0.30 with consistent sign in ≥75%; **rewired** if |mean| < 0.30 but contrast-to-contrast sign disagreement (sign-consistency 50% within stressor); **n.s.** otherwise.
- Thresholds: 0.30 chosen to match the Stage E narrative threshold (|+0.42|, |+0.72|, |−1.73| as anchor effect-sizes).

**4.2.3 Metabolic-module readout.** Eight modules per user request: ROS metabolism, energy metabolism, photosynthesis, photorespiration, carbon metabolism, ABA metabolism, GA metabolism, hormone transport. Map onto the existing 31 pathways:
| User module | Pathways used |
|---|---|
| ROS metabolism | ROS_core_NMF, ROS_scavenging (Maffei panels) |
| Energy metabolism | Oxidative_phosphorylation, TCA_cycle (KEGG) |
| Photosynthesis | Photosynthesis, Photosynthesis_antenna_proteins, Carbon_fixation_in_photosynthetic_organisms |
| Photorespiration | Glyoxylate_and_dicarboxylate_metabolism (KEGG proxy) |
| Carbon metabolism | Glycolysis_Gluconeogenesis, Pentose_phosphate_pathway, Starch_and_sucrose_metabolism |
| ABA metabolism | ABA_biosynthesis, ABA_signaling |
| GA metabolism | GA_biosynthesis, GA_signaling, Diterpenoid_biosynthesis |
| Hormone transport | Auxin_transporters_ABCB, AUX_LAX, PIN |
+ new: NMF cluster A–E pseudo-pathways from §4.1.5.

### 4.3 Integration into the cross-stressor matrix

Build `integrated_stressor_matrix.csv` with columns:
`tissue, module, stressor, mean_score, label{activated/suppressed/rewired/ns}, evidence_tier{T1/T2/T3/T4}, n_supporting_contrasts, note`.

Per cell, record:
- T1 anchor if there's a pathway-activity score (e.g., GA_biosynthesis OSD-678 leaf dark = −1.730 → tissue=shoot, stressor=µg, label=suppressed, T1).
- T2 anchor if it comes from cell-type enrichment (e.g., Vasculature_shoot at OSD-678 leaf dark singscore + FDR).
- T3/T4 if only literature or hypothesis (e.g., embryo, NMF cell-type).

Identify per-cell:
- **Common mechanisms** (label agrees across ≥2 stressors AND same tissue): catalogued separately.
- **µg-unique / GCR-unique / NMF-unique**: stressor produces a label not produced by the other two in the same tissue.

### 4.4 NMF causal chain figure (Figure 12)

Causal chain:
```
                                        magnetoreception (T3, [15])
                                             ↓
NMF (≤100 nT field)  ────────────►   transcriptional reprogramming
                                             ↓
                              ┌──────────────┼──────────────┐
                              ↓              ↓              ↓
                       ROS clusters    Polyphenols    GA biosynthesis
                       A=shoot-up    (S5: ↑ in NNMF   (T1: +0.722
                       B=both-up      shoot 24h–96h)   shoot 96h)
                       D=late-up                          ↓
                       E=early-up                    DELLA release
                              ↓              ↓              ↓
                      H2O2 transcripts  Antioxidant   Germination
                       ↑                 capacity ↑    acceleration
                       (S4)             (Tukey ***)   (T3 [15])
                              ↓
                       H2O2 PROTEIN ↓ (S3 — paradox; T1/T3 tension)
```

Includes per-arm tier badges, falsification ports (ga1-3 + cry1cry2 + clinostat experiments).

### 4.5 Integrated systems-biology figure (Figure 13)

Layered diagram:
- **Row 1 (stressor box):** µg, GCR, NMF as three vertical lanes.
- **Row 2 (cellular programs):** ROS, DNA-damage (GCR-specific, T3), cluster A–E (NMF), oxidative-stress transcripts (µg leaf-dark).
- **Row 3 (tissue programs):** vascular suppression (7/7 from cross-dataset table), hypocotyl context-dependent (0/3), shoot vs root inversion, embryo (T3 only with explicit caveat).
- **Row 4 (metabolic):** the eight modules from §4.2.3 with sign per stressor.
- **Row 5 (hormone signalling):** ABA, GA, auxin transport — with the +1.407 / −1.730 / +0.722 anchors.
- **Row 6 (germination phenotype):** accelerated (NMF, T3), delayed (µg, T3), biphasic (GCR low/high dose, T3).

Edges colour-coded by tier (T1 solid, T2 dashed, T3 dotted, T4 grey). Each anchor labelled with its number from disk.

### 4.6 Two PDFs

**4.6.1 `nmf_systems_biology_summary.pdf` (~6 pages).** Focused on NMF only:
- Page 1: Headline + 1-paragraph context.
- Page 2-3: Cluster A–E temporal profile (Figure 10) + polyphenol summary (Figure 11).
- Page 4: H2O2 transcript-vs-protein tension table.
- Page 5: Full NMF systems-biology causal chain (Figure 12).
- Page 6: Falsification tests + tiered evidence summary.

**4.6.2 `integrated_systems_biology_report.pdf` (~15-20 pages).** Comprehensive:
- Pages 1-2: Executive summary + the stressor-by-stressor headline.
- Pages 3-5: Single-cell mapping (synthesis of existing cell-type enrichment), tissue-stressor table.
- Pages 6-9: Metabolic-module activity by tissue × stressor (5 × 4 × 8 grid).
- Pages 10-12: Integration — the four findings classes (common / µg-only / GCR-only / NMF-only).
- Pages 13-15: Figure 13 (integrated systems biology) + caveats + tier audit.
- Pages 16-18: Falsification suite + appendix.

Both PDFs reference the locked Stage E report; neither modifies it.

## 5. Compute estimate

| Step | Cost |
|---|---|
| Parse S2-S7, build cluster profile | seconds (in-kernel pandas, <50 MB) |
| Tissue × stressor × pathway aggregation | seconds (620-row table) |
| 4 new figures (matplotlib, ≤300 dpi) | <30 s each |
| Both PDFs (reportlab) | <15 s each |

No new HPC, no large machine, no FBA / GENRE construction. Default `worker-0` is fine. Total wall-time estimate: **30-45 minutes** of foreground work.

## 6. Acceptance / test criteria

1. **Cluster heatmap anchor.** Cluster B shoot row max ratio ≥ 2.0 (raw NMF/MF) corresponds to a single value matching the S2 sheet's strongest B entry to within rounding.
2. **Polyphenol Tukey echo.** At least one polyphenol class shows NNMF-shoot-vs-GMF-shoot at 24h or 96h with a *** flag from S6, and this *** is reproduced verbatim in `nmf_polyphenol_content.csv` and quoted in the NMF PDF.
3. **Stage E parity.** The NMF GA-biosynthesis shoot 96h anchor in the new tissue-stressor table equals **+0.722** to 3 d.p., matching `report_seed_germination_mechanism.md` exactly.
4. **OSD anchor parity.** OSD-678 leaf-dark GA_biosynthesis = **−1.730** is reproduced exactly.
5. **No file leakage.** mtime of `report_seed_germination_mechanism.md` and `09_mechanistic_model.png` is older than the start of this run; verified at write-out.
6. **Citation discipline.** All literature claims (Yin 2024, Parmagnani 2022, Agliassa 2018, Dhiman 2022) carry the same numeric indices as in references.jsonl, looked up before quoting (no memory citations).
7. **Tier audit.** Every claim in either PDF carries a T1/T2/T3/T4 marker; the integrated PDF includes a 1-page audit summarising counts per tier.
8. **Embryo & NMF cell-type explicit limitation.** Both PDFs declare in caveats that embryo direct data are absent and NMF cell-type enrichment was not computed because the 194-gene panel under-overlaps cell-type marker panels.
9. **Figure 12 readability check.** Use `Read(mode="media_output_check")` on the NMF systems-biology figure to confirm the causal chain is legible, all tier badges render, and no labels are clipped.

## 7. Risks and assumptions

- **A1.** Maffei "ratio" columns in S2 are interpreted as NNMF/GMF (NMF over geomagnetic, paper convention) → log2 of values used as log2 fold-change. Already validated against the on-disk `long_NMF_Maffei2022.csv.gz` (which has matching log2 values).
- **A2.** OSD-658 "whole-seedling" tissue cannot be tissue-disambiguated — flagged as such in the matrix.
- **A3.** "Embryo" tissue cannot be addressed from data — declared T3-only.
- **A4.** Maffei cluster letters E (n=8), C (n=11), D (n=14) are small; cluster-level patterns are descriptive, not statistically tested. Stated as a limitation in PDFs.
- **A5.** Polyphenol HPLC values use the paper's units (likely mg/g DW or area-units). Not re-normalised. Tukey HSD significance flags carry directly from S6.
- **R1.** If the cluster letters in S2 are not pre-published clusters but a hand-annotated grouping, the labels may not be standard k-means. Will document the cluster assignment process verbatim from the paper text in the notes file.

## 8. Execution order

1. Run §4.1 NMF zip parsing → 5 new NMF tables in /mnt/results/tables/.
2. Run §4.2 tissue-stressor aggregation → `tissue_pathway_summary.csv` and `integrated_stressor_matrix.csv`.
3. Render Figures 10 + 11 + 12 + 13.
4. Build `nmf_supplement_analysis.md` notes file.
5. Run §6 acceptance checks, fix any failures, re-run.
6. Build both PDFs (NMF-only first, integrated second).
7. Visual check Figure 12 in particular.
8. Surface headline result to user with file list.


---

# PLAN ADDENDUM — Part 1-3 Unified Germination Model PDF (new request, post-completion)

## 9. Summary of new request

User asks for a single new PDF that performs three integrated tasks:

1. **Part 1 — Single-cell atlas projection.** Map the OSD + Maffei expression signals onto 9 tissues (embryo, endosperm, seed coat, hypocotyl, radicle, root, shoot, vascular, meristematic), identify enriched cell types, build "cell-state clusters", and contrast shared vs. stressor-specific cell-state responses.
2. **Part 2 — Tissue-specific metabolic modelling.** For each tissue × stressor cell, classify 8 module classes (ROS, energy, photosynthesis, photorespiration, carbon, ABA, GA, hormone transport) as activated / suppressed / rewired.
3. **Part 3 — Integrated mechanistic model.** Build cell-type interaction model, tissue interaction model, tissue-specific metabolic model, and a unified mechanistic germination model. Classify every claim as **Direct dataset / Atlas projection / Literature / Hypothesis**, surface common vs. unique mechanisms, identify the most vulnerable cell populations, name master regulators, and list testable hypotheses with confidence levels (High / Medium / Low).

## 10. Honest scope assessment — what's already done vs. what's new

After exhaustive inventory of `/mnt/results/tables/` (35 tables) and `/mnt/shared-workspace/deepspace/clean/` (atlases + stageD + NMF), **the majority of the analytical substrate already exists**. The new work is primarily **synthesis + reformatting** with one new analytical layer (master-regulator identification + confidence scoring + cell-state cluster discovery from existing singscores). The PDF re-presents existing artifacts under the requested evidence taxonomy.

### Mapped against the user's 3-part request

| User request | Status on disk | New work needed |
|---|---|---|
| 9-tissue mapping | 5 tissues addressable (root, shoot, vascular, hypocotyl, whole_seedling); 4 tissues T3-only (embryo, endosperm, seed_coat, radicle); meristematic = atlas-only (SAM_shoot, QC_rootcap, InitialCell_root, Procambium_root). | Build explicit 9-tissue × 3-stressor × 8-module reachability matrix with evidence labels. |
| Cell-type projection | `celltype_enrichment_combined_Han_Liew.csv` (186 rows = 31 cell-types × 6 OSD conditions, Han+Liew). | Already complete. Re-summarise into 9-tissue groupings. |
| Cell-state clustering | NOT done. No raw scRNA-seq counts available; only marker-panel singscores per condition × cell-type. | New: hierarchical-cluster the 6 conditions × 31 cell-type singscores → "condition cell-state clusters" (NOT true scRNA-seq clustering — explicit limitation). |
| Shared vs. stressor-specific cell-states | Partially done (`integrated_celltype_pattern.csv`, 10 rows for µg vs. GCR vascular + hypocotyl). | Extend: explicit common / µg-only / GCR-only / NMF-projection-unavailable annotation. NMF cell-type stays infeasible (panel-size limit; documented). |
| 8-module metabolic modelling | Done (`tissue_pathway_summary.csv` 155 rows + `integrated_stressor_matrix.csv` 188 rows with activated / suppressed / rewired labels for 31 pathways → 8 module classes via the §4.2.3 mapping). | New: explicit 9×3×8 grid summary table + a flagging of which module classes have data per cell. |
| Cell-type interaction model | Partial (`seed_tissue_network_edges.csv` 335 KB, `network_node_module_assignment.csv` with 11 module labels). | New: project the gene-gene network onto cell-type × cell-type adjacency by aggregating each gene's primary atlas cell-type. |
| Tissue interaction model | Partial (`inter_module_edge_counts.csv` already has module-module connectivity; integrated_stressor_pattern.csv has 93 tissue × stressor patterns). | New: explicit tissue-tissue adjacency table summarising cross-tissue overlap. |
| Tissue-specific metabolic model | Done (`tissue_pathway_summary.csv`). | New: per-tissue 8-module activity vector. |
| Unified mechanistic model | Done (figures 09, 12, 13 already on disk). | New: collapse all three into one figure with stressor-tissue-cell-type-module evidence overlay. |
| Direct/Atlas/Literature/Hypothesis classification | Existing tiers T1 (data) / T2 (atlas+network) / T3 (literature) / T4 (hypothesis) cover this exactly. | Rename T1→Direct, T2→Atlas, T3→Literature, T4→Hypothesis in the new PDF for user-facing clarity. Internally keep T1-T4 in tables. |
| Common vs. unique mechanisms | Done (`integrated_stressor_pattern.csv` 93 rows with pattern column: common:µg,NMF / µg_only:activated / etc.). | Re-summarise + count. |
| Most vulnerable cell populations | NOT explicitly named. | New: rank cell-types by mean |singscore| across stressors (highest = most reprogrammed = most vulnerable proxy). Top 5 named. |
| Master regulators | NOT explicitly identified. | New: rank network hubs by (a) degree centrality (`network_node_module_assignment.csv` degree column), (b) cross-stressor sign consistency in `cross_dataset_enrichment_meta.csv`, (c) presence in two or more pathway modules. Top 10 named with TAIR + symbol + module + evidence tier. |
| Testable hypotheses with confidence | F1-F10 falsification ports already exist across the two PDFs. | New: re-rank with explicit High/Medium/Low confidence and the falsifying experiment per hypothesis. |

## 11. New analytical work (only what is genuinely missing)

### 11.1 Condition cell-state clustering (Part 1)

- Input: `celltype_enrichment_combined_Han_Liew.csv` (186 rows × 8 cols).
- Pivot to a 6-condition × 31-cell-type singscore matrix.
- Hierarchical-cluster conditions (rows): correlation distance + Ward linkage → expect µg-light, µg-dark, GCR-40, GCR-80, leaf-light, leaf-dark to cluster by stressor first, light second.
- Hierarchical-cluster cell-types (cols): expect vascular cluster (Xylem, Phloem, Procambium, Liew_xylem, Liew_provasculature) and meristematic cluster (SAM, InitialCell, Procambium, QC_rootcap) to emerge.
- Output: `tables/cell_state_cluster_assignment.csv` + figure `14_cell_state_dendro_heatmap.png`.
- **Explicit limitation**: this is condition-cell-state, NOT raw-scRNA-seq cell-state. We don't have access to single-cell counts for the experimental conditions.

### 11.2 Master-regulator ranking (Part 3)

- Input: `network_node_module_assignment.csv` (1,153 nodes × degree, mean_log2fc_OSD_dark, mean_log2fc_OSD_light, modules) + `cross_dataset_enrichment_meta.csv` (10 programs × Z_combined, fdr_bh, sign_concordance_frac).
- Compute composite regulator score:
  - `degree_centile = percentile(degree)` (network connectivity)
  - `cross_stressor_robustness = |Z_combined|` from cross-dataset meta-analysis (if applicable)
  - `direction_consistency = sign_concordance_frac` from meta
  - `multi_module = (1 if "modules" cell contains ";" else 0)` (cross-talk node)
  - `master_score = 0.4·degree_centile + 0.3·robustness_centile + 0.2·direction_consistency + 0.1·multi_module`
- Top 10 by master_score, output to `tables/master_regulators_top10.csv`.
- For each, attach a Direct / Atlas / Literature evidence flag and cite from existing references.

### 11.3 Vulnerable cell-population ranking (Part 3)

- Compute mean |singscore| across all 6 conditions per cell-type from `celltype_enrichment_combined_Han_Liew.csv`.
- Higher = more reprogrammed = candidate "vulnerable" population.
- Output: `tables/vulnerable_cell_populations.csv` (31 rows ranked).
- Top 5 named in PDF with mean magnitude + per-stressor breakdown.

### 11.4 9-tissue evidence reachability matrix (Part 1 + Part 2)

- Tissues: embryo, endosperm, seed_coat, hypocotyl, radicle, root, shoot, vascular, meristematic.
- Stressors: µg, GCR, NMF.
- Modules: ROS, energy, photosynthesis, photorespiration, carbon, ABA, GA, hormone_transport (8).
- Cells filled with Direct / Atlas / Literature / Hypothesis evidence level + label (activated / suppressed / rewired / not_assessable).
- Output: `tables/nine_tissue_evidence_matrix.csv` (216 cells = 9×3×8).

### 11.5 Testable hypothesis suite with confidence levels (Part 3)

- 8-12 hypotheses, each with:
  - Statement (1-2 sentences)
  - Evidence tier (Direct / Atlas / Literature / Hypothesis)
  - Confidence (High / Medium / Low) — High = multi-stressor consistency + Direct + Atlas convergence; Medium = single-stressor Direct + Literature support; Low = Hypothesis only.
  - Falsifying experiment (genotype + condition + observable + threshold)
- Output: `tables/testable_hypotheses_ranked.csv` + Section 7 in the PDF.

## 12. Outputs (new, never overwrite existing)

```
/mnt/results/
  tables/
    cell_state_cluster_assignment.csv      # condition × cell-state cluster
    nine_tissue_evidence_matrix.csv        # 9×3×8 cells with Direct/Atlas/Lit/Hyp
    master_regulators_top10.csv            # ranked composite score
    vulnerable_cell_populations.csv        # ranked by |singscore| magnitude
    testable_hypotheses_ranked.csv         # 8-12 hypotheses + confidence
    cell_type_interaction_summary.csv      # cell-type × cell-type module-shared edges
    tissue_interaction_summary.csv         # tissue-tissue overlap
  figures/
    14_cell_state_dendro_heatmap.png/.svg  # 6-condition × 31-cell-type dendrogram
    15_master_regulator_panel.png/.svg     # top-10 master regulators + their modules
    16_unified_germination_model.png/.svg  # consolidated 5-row layered diagram
  unified_germination_model.pdf            # NEW PDF (~22-25 pages)
```

**Locked / unchanged**: every existing file in `/mnt/results/` including the two prior PDFs, all figures 01-13, all 35 existing tables, the locked Stage E report, the supplement notes, the references.jsonl.

## 13. PDF structure (`unified_germination_model.pdf`)

| Pages | Section | Content |
|---|---|---|
| 1 | Cover + executive summary | 5-bullet headlines + tier legend (Direct / Atlas / Literature / Hypothesis = High / Medium / Low confidence) |
| 2-3 | Part 1.1: 9-tissue mapping | Reachability matrix table + which tissues are addressable per stressor + the 4 tissues that are literature-only (embryo, endosperm, seed_coat, radicle) |
| 4-5 | Part 1.2: Cell-type enrichment summary | Top enriched cell-types per stressor + Han+Liew atlas singscore table + Figure 4 reference |
| 6-7 | Part 1.3: Condition cell-state clusters | Figure 14 dendro/heatmap + cluster membership table |
| 8-9 | Part 1.4: Shared vs. stressor-specific cell-states | Common (µg+GCR vascular) vs. µg-only (hypocotyl) vs. NMF-uncovered + Figure 13 reference |
| 10-12 | Part 2.1: Tissue-specific metabolic model | 9×3×8 module-activity grid table |
| 13-14 | Part 2.2: Tissue interaction model | Inter-tissue overlap (root-shoot rewiring, light × dark inversion 13 cells) |
| 15-16 | Part 3.1: Cell-type interaction model | Network module-module edge counts + 7-module overview |
| 17-18 | Part 3.2: Master regulators | Top-10 table + Figure 15 + per-regulator module assignment + evidence tier |
| 19 | Part 3.3: Most vulnerable cell populations | Top-5 ranked + per-stressor breakdown + 31-cell-type full table reference |
| 20-21 | Part 3.4: Unified mechanistic model | Figure 16 + 5-row layered diagram + tier-coloured edges |
| 22-23 | Part 3.5: Testable hypotheses with confidence | 8-12 hypotheses ranked by confidence + falsifying experiment per hypothesis |
| 24 | Limitations + caveats | L1-L8 from prior PDF + 4 new: cell-state-clustering proxy, embryo/endosperm/seed_coat/radicle T3-only, NMF cell-type infeasible, master-regulator composite formula |
| 25 | References + file appendix | Full reference list [1-25] + table-of-deliverables for cross-reference |

## 14. Compute budget

| Step | Tool | Cost |
|---|---|---|
| Hierarchical clustering (6×31) | scipy.cluster, in-kernel | <5 s |
| Master-regulator composite score | pandas merge + rank, in-kernel | <5 s |
| 9×3×8 reachability matrix | pandas pivot + label rules | <5 s |
| Vulnerable-population ranking | pandas mean abs + rank | <2 s |
| Figure 14 (dendro heatmap) | seaborn clustermap | ~10 s |
| Figure 15 (master regulator panel) | matplotlib | ~15 s |
| Figure 16 (unified model) | matplotlib + custom layout | ~30 s |
| `unified_germination_model.pdf` build | reportlab | ~30 s |

No HPC, no large machine, no scRNA-seq re-clustering (raw counts unavailable), no FBA construction. Default `worker-0` is fine. Total wall-time: **45-60 minutes** end-to-end.

## 15. Acceptance / test criteria for the new PDF

1. **Anchor parity v2.** All Stage E anchors (OSD-678 leaf-dark GA = −1.730, OSD-120 root-dark ABA-biosynthesis = +1.407, Maffei NMF shoot 96h GA-biosynthesis = +0.722) are echoed in the new PDF with the same numeric values to ≥3 d.p.
2. **9×3×8 matrix coverage.** All 216 cells are populated with one of {Direct, Atlas, Literature, Hypothesis, not_assessable}. No "TBD" cells.
3. **Master regulator count.** Exactly 10 master regulators are named with TAIR + symbol + module + tier in the table.
4. **Vulnerable population count.** Exactly 5 cell-types named with mean |singscore| values that match the underlying table.
5. **Hypothesis count.** Between 8 and 12 testable hypotheses, each with confidence + falsifying experiment.
6. **Citation discipline (v2).** Every literature anchor in the new PDF carries the same numeric index as in references.jsonl. No new citations; no Vandenbrink/Paul/De Micco names not present in references.jsonl.
7. **Tier legend correctness.** The Direct/Atlas/Literature/Hypothesis legend in the PDF maps 1:1 to T1/T2/T3/T4 in the tables.
8. **Figure 16 visual check.** `Read(mode="media_output_check")` on `16_unified_germination_model.png` confirms 5-row layered diagram is legible, tier-coloured edges render, no labels clipped.
9. **No existing-file overwrites.** mtimes of all pre-existing PDFs, figures, tables, and markdown reports unchanged after the run.
10. **Honest limitations.** The PDF explicitly states cell-state clustering is a condition-cell-state proxy (NOT raw scRNA-seq); embryo/endosperm/seed_coat/radicle are T3-only; NMF cell-type projection infeasible; master-regulator score is composite + formula provided.

## 16. Execution order

1. Read existing artifacts (celltype enrichment, integrated stressor matrix, network module assignment, cross-dataset meta) into kernel.
2. Build `cell_state_cluster_assignment.csv` + Figure 14 (hierarchical cluster).
3. Build `nine_tissue_evidence_matrix.csv` (9×3×8 = 216 cells).
4. Build `vulnerable_cell_populations.csv` (31 rows ranked).
5. Build `master_regulators_top10.csv` (composite score, top 10).
6. Build `cell_type_interaction_summary.csv` + `tissue_interaction_summary.csv` from existing network.
7. Build `testable_hypotheses_ranked.csv` (8-12 hypotheses with confidence + falsifying experiment).
8. Render Figure 15 (master regulator panel) + Figure 16 (unified mechanistic model).
9. Run acceptance checks §15.1-§15.10.
10. Build `unified_germination_model.pdf` (24-25 pages).
11. Final visual + content check.
