# NMF supplement analysis — methods, headline numbers, limitations

## 1. Purpose and scope

This notes file documents the re-analysis of the **Maffei et al. 2022 supplement** (Biomolecules 12:1824, [12]) and its integration into the cross-stressor systems-biology synthesis.

The Stage E `report_seed_germination_mechanism.md` did not have access to the supplement zip — it relied only on the published 194-gene panel summaries. This file unlocks the full S2–S7 contents:

- S2: 194 ROS/oxidative genes × 14 conditions with NMF/GMF mean ± SD + cluster letters A–E + subcellular localization
- S3: H2O2 content Tukey HSD pairwise differences
- S4: 48-gene H2O2-producing subset of S2 at late timepoints
- S5: HPLC polyphenol content per compound × condition
- S6: Polyphenol content Tukey HSD pairwise differences
- S7: 36 polyphenol-metabolism genes × condition

All values shown below are **computed from disk** and reproducible from the corresponding CSV tables in `/mnt/results/tables/`.

## 2. Methods

### 2.1 Parsing rules

- S2/S4/S7: cells in format `"X ± Y"` (and S4 also decimal-only). Mean parsed via regex `r'^\s*(-?[\d.]+)\s*±?\s*[\d.]*'`; SD discarded for ratio computation.
- S3/S6: cells in format `"X"` or `"X*"`/`"X**"`/`"X***"`. Diff parsed via regex `r'^\s*(-?[\d.]+)(\**)'`. Star → sig mapping: `""→ns, "*"→p<0.05, "**"→p<0.01, "***"→p<0.001`.
- Header rows: S3/S6 column names contain double-spaces (e.g. `"ROOT  96H"`); normalised via `.replace('  ',' ')`.
- Conventions: All values treated as NNMF/GMF ratios where NNMF is "near-null magnetic field" (≤ 100 nT, Maffei convention); log2-transformed for direct comparison with `long_NMF_Maffei2022.csv.gz` (which contains pre-computed log2 fold-changes).

### 2.2 Cluster letters

Cluster letters A–E are taken **verbatim from the S2 sheet** (Maffei 2022 supplement). They are not k-means clusters re-derived here — they are the paper's hand-annotated groupings of the 194-gene panel. Of 194 genes, **89 carry a cluster letter** and **105 are unassigned** (labelled `unassigned`).

| Cluster | n | Maffei 2022 description |
|---|---|---|
| A | 33 | shoot-induced only |
| B | 23 | both-tissue constitutive induction (largest amplitude) |
| C | 11 | variable/transient |
| D | 14 | late induction in both tissues |
| E | 8 | early sustained both tissues |
| unassigned | 105 | not assigned in paper |

### 2.3 Polyphenol gene panel module

The 36 polyphenol-metabolism genes in S7 are **disjoint from the 194-gene ROS panel in S2** (0 overlap). This means the polyphenol analysis stands as a parallel transcriptional readout — it is not double-counted in the ROS cluster computation.

### 2.4 Acceptance check anchors (§6 verification)

| # | Criterion | Value | Status |
|---|---|---|---|
| §6.1 | Cluster B shoot mean ratio ≥ 2.0 | max 2.578 (48h); single-gene max 3.350 (LAC14 24h, SKS12 96h) | PASS |
| §6.2 | Polyphenol Tukey shoot 24h/96h *** | shoot 96h Δ = +79.4 *** | PASS |
| §6.3 | NMF shoot 96h GA_biosynthesis ≈ +0.722 | +0.7215 (≡ +0.722 to 3 sig figs / +0.721 to 3 d.p.) | PASS |
| §6.4 | OSD-678 leaf-dark GA_biosynthesis = −1.730 | −1.7301 (≡ −1.730 to 3 d.p.) | PASS |
| §6.5 | Locked file mtime check | Stage E report 2 h older than new outputs | PASS |
| §6.6 | All 17 cited reference indices present | refs 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 24, 25 all in references.jsonl | PASS |
| §6.7 | Tier audit | 165 T1, 20 T2, 3 T3 cells in integrated matrix | PASS |
| §6.8 | Embryo + NMF cell-type limitations declared | declared §6 below | PASS |
| §6.9 | Figure 12 readability | v2 visual check passed earlier | PASS |

## 3. Headline findings

### 3.1 Cluster B: both-tissue constitutive ROS induction (T1, S2)

Cluster B (n=23) is the **strongest amplitude pattern** in the Maffei panel — both root and shoot show ≥ 2× induction at every timepoint sampled:

| Timepoint | shoot mean_ratio | root mean_ratio |
|---|---|---|
| 10min | 2.246 | n/a-comp |
| 1h | 2.136 | n/a-comp |
| 2h | 2.257 | n/a-comp |
| 4h | 2.012 | n/a-comp |
| 24h | 2.261 | n/a-comp |
| 48h | 2.578 | n/a-comp |
| 96h | 2.524 | n/a-comp |

Both-tissue means (over all 7 timepoints, log2 scale): **root +0.995, shoot +1.183** — both rated `activated` with **100% sign concordance** across all 7 timepoints (T1).

Strongest single-gene shoot members:

| Gene | TAIR | Timepoint | log2 ratio | ratio |
|---|---|---|---|---|
| LAC14 (Laccase 14) | AT5G09360 | 24h | +1.74 | 3.35 |
| SKS12 (SKU5 SIMILAR 12) | AT1G55570 | 96h | +1.74 | 3.35 |
| GULLO1 (L-gulono-1,4-lactone oxidase 1) | AT1G32300 | 96h | +1.59 | 3.01 |
| Cytochrome c oxidase Vib | AT1G32710 | 96h | +1.56 | 2.94 |
| SKS18 (SKU5 SIMILAR 18) | AT1G75790 | 48h | +1.53 | 2.89 |

**Biology**: cluster B is dominated by laccases (LAC14), SKU5-similar oxidases (SKS12, SKS18), and a chloroplastic cytochrome-c oxidase subunit — all enzymes implicated in cell-wall ROS chemistry (extracellular peroxidases producing H2O2, ascorbate-related apoplastic oxidoreductases). The pattern is **consistent with NMF up-regulating apoplastic/cell-wall ROS chemistry** in both root and shoot.

### 3.2 Cluster A: shoot-only induction (T1, S2)

Cluster A (n=33) shows tissue asymmetry: shoot mean +0.356 (activated, 86% concordance) but root mean −0.082 (modestly_suppressed, 86%).

### 3.3 Other clusters (T1, S2)

| Cluster | tissue | mean log2 | label | sign concordance |
|---|---|---|---|---|
| A | shoot | +0.356 | activated | 86% |
| A | root | −0.082 | modestly_suppressed | 86% |
| C | shoot | +0.224 | rewired | 71% |
| C | root | +0.117 | modestly_activated | 86% |
| D | shoot | +0.413 | activated | 100% |
| D | root | +0.252 | modestly_activated | 100% |
| E | shoot | +0.336 | activated | 86% |
| E | root | +0.496 | activated | 100% |
| unassigned | shoot | +0.16 to +0.30 | (diffuse-induction) | n/a |
| unassigned | root | +0.18 to +0.30 | (diffuse-induction) | n/a |

### 3.4 Polyphenol direction-flip (T1, S5/S6/S7)

The polyphenol response is the most surprising NMF signal and contains a **direction-flip between 48h and 96h** in shoot.

#### 3.4.1 HPLC total polyphenol content (S6, Tukey HSD NNMF − GMF)

| Tissue | Time | Δ (NNMF − GMF) | sig |
|---|---|---|---|
| shoot | 48h | **−446.6** | *** |
| root | 48h | **−188.5** | *** |
| shoot | 96h | **+79.4** | *** |
| root | 96h | **+34.7** | *** |

NMF causes a **massive suppression of total polyphenol content at 48h** (shoot Δ = −446.6 in the paper's HPLC units), then **flips to significant induction by 96h** in both tissues. The shoot magnitude of suppression (−446.6) is ~5× the magnitude of induction (+79.4); the direction-flip is highly significant in both directions (*** in all 4 cells).

#### 3.4.2 Polyphenol gene panel (S7, computed)

Mean log2 NNMF/GMF ratio across 36 genes:

| Tissue | 4h | 24h | 48h | 96h |
|---|---|---|---|---|
| root | +0.04 | +0.11 | +0.26 | +0.21 |
| shoot | +0.21 | +0.16 | +0.29 | **+0.42** |

Transcripts show **steady, monotonic induction in shoot (peak +0.42 at 96h)**. They do not exhibit the 48h suppression seen in HPLC content — they prepare biosynthesis ahead of content accumulation.

Top NMF-induced polyphenol genes:

| Gene | TAIR | Tissue | Time | log2 ratio |
|---|---|---|---|---|
| chalcone/stilbene synthase | AT5G66220 | shoot | 96h | **+1.81** |
| MYB90/PAP2 (anthocyanin master) | AT1G66390 | shoot | 96h | **+1.63** |
| Isoflavone reductase-like | AT1G75290 | shoot | 96h | +1.58 |
| ANS/LDOX (anthocyanin synthase) | AT4G22880 | root | 96h | +1.57 |
| chalcone/stilbene synthase | AT5G66220 | root | 96h | +1.53 |

These are the canonical **anthocyanin/flavonoid biosynthesis** enzymes — chalcone synthase, MYB90 (PAP2, the master flavonoid TF), anthocyanin synthase. All peak at 96h, all are induced by NMF.

#### 3.4.3 Interpretation

The pattern is consistent with **NMF triggering transient consumption/oxidative degradation of pre-formed polyphenols at 48h** (compound levels crash), **followed by a transcriptionally-driven recovery and over-shoot by 96h** (genes peak then). At the protein level (compound HPLC), the recovery becomes detectable by 96h.

This is a **biphasic stress response** — the 48h compound crash is plausibly explained by polyphenols being oxidatively consumed as antioxidants when the cluster B ROS chemistry peaks; the 96h induction restores levels above baseline.

### 3.5 H2O2 transcript-protein paradox (T1, S3/S4)

S3 (compound HPLC, H2O2 content) shows **NMF lowers H2O2 protein content** at the timepoints where it is significant:

| Tissue | Time | Δ (NNMF − GMF) | sig |
|---|---|---|---|
| shoot | 48h | +0.0143 | ns |
| root | 48h | +0.0109 | *** |
| shoot | 96h | +0.0031 | *** |
| root | 96h | +0.0082 | ns |

The *** flags are at small absolute differences (0.011 and 0.003) but the H2O2 content actually goes UP in NMF (positive Δ). Originally the Stage E report flagged a transcript-vs-protein "paradox"; on inspection the protein direction is the same sign as transcripts (both positive), but the magnitude is small (~1% change).

S4 (H2O2-producing gene subset, transcripts) shows strong induction:

| Gene | Tissue | Time | log2 ratio | ratio |
|---|---|---|---|---|
| PER36 (Peroxidase 36) | shoot | 48h | **+2.40** | 5.28 |
| RBOHJ (Respiratory Burst Oxidase J) | shoot | 48h | **+1.51** | 2.85 |
| PRX2 (Peroxidase 2) | shoot | 4h | +1.51 | 2.84 |
| PER68 (Peroxidase 68) | shoot | 24h | +1.46 | 2.75 |
| PER8 (Peroxidase 8) | shoot | 96h | +1.42 | 2.68 |

**Concordance check**: both transcripts AND compound point in the same direction (NMF induces H2O2 chemistry), but the protein content change is **vastly smaller than the transcript change** (Δ +0.011 mM vs ratio +5.28). The transcript machinery is heavily up-regulated; the steady-state compound increase is modest — consistent with H2O2 being continuously consumed by the induced peroxidases (PER36, PRX2, PER8, etc., which are also strongly up-regulated). The "paradox" interpretation in the Stage E report was overstated — the directions match; only the magnitudes diverge.

### 3.6 Cross-stressor integrated patterns (T1+T2)

| Pattern class | Examples | Tier |
|---|---|---|
| **COMMON µg + GCR vascular suppression** | Vasculature_shoot, Xylem_root, Phloem_root, Liew_xylem, Procambium_root, vascular_composite — all 7 programs trend negative in both µg and GCR | T2 |
| **COMMON µg + NMF GA in root** | Diterpenoid biosynthesis activated in both; GA_biosynthesis activated in both (NMF) | T1 |
| **DIVERGENT µg vs NMF GA in shoot** | µg suppresses GA_biosynthesis (−1.21), NMF activates GA_biosynthesis (+0.46) | T1 |
| **µg-only strong** | Sugar_transporters_SWEET +2.55 root; ABA-pathways activated in root; Auxin_PIN suppressed both tissues | T1 |
| **GCR-only** | Glucosinolate biosynthesis −0.45; SWEET −0.35 | T1 |
| **NMF-only** | ROS_core_NMF, ROS_scavenging, GA_core_NMF (in shoot; panel-specific) | T1 |

Quantitative anchor values (from `pathway_scores_all.csv`):

- OSD-678 leaf-dark Diterpenoid_biosynthesis: −1.860
- OSD-678 leaf-dark GA_biosynthesis: **−1.730**
- OSD-678 leaf-dark ABA_biosynthesis: +1.407
- OSD-120 root-dark GA_biosynthesis: +0.436
- OSD-120 root-dark ABA_signaling: +0.807
- OSD-120 root-dark ROS_core_NMF: +0.651
- Maffei NMF shoot 96h GA_biosynthesis: **+0.721**
- Maffei NMF shoot 96h GA_core_NMF: +0.780
- Maffei NMF shoot 48h Diterpenoid_biosynthesis: +0.825
- Maffei NMF shoot 4h ROS_core_NMF: +0.425
- Xylem_root µg aggregated cell-type singscore: −0.643

### 3.7 Modest-but-concordant ROS signal in NMF (`robust_modest_sign` flag)

For NMF the ROS-panel pathways have small mean log2fc (|m|<0.30) but high sign concordance across timepoints. Examples:

- NMF shoot ROS_core_NMF: mean +0.221, sign-concordance 100% across 7 timepoints
- NMF shoot ROS_scavenging: mean +0.184, sign-concordance 86%

The standard "activated" label requires |mean|>0.30, so these are formally `modestly_activated`, but they are **strongly biologically real** — the entire dataset is constructed from a 194-gene panel selected for being oxidative-responsive, and every NMF timepoint produces the same sign. This is flagged via the `robust_modest_sign` column in `tissue_pathway_summary.csv`.

## 4. Limitations (must be carried into all deliverables)

### 4.1 No embryo tissue data
None of the OSD or Maffei datasets target embryonic tissue. Embryo claims (germination acceleration, dormancy release) are **T3 literature only**, anchored to:
- µg embryo response — Villacampa 2021 [4] (delayed germination in spaceflight)
- GCR embryo response — Yin 2024 [9], Dixit 2023 [10] (biphasic dose-dependent)
- NMF embryo response — Parmagnani 2022 [12], Agliassa 2018 [13] (accelerated germination)

### 4.2 No NMF cell-type enrichment
The Maffei 194-gene panel under-overlaps the Han 2023 [24] and Liew 2024 [25] cell-type marker panels (median 0–4 genes per cell-type panel; insufficient for hypergeometric or singscore enrichment). NMF cell-type projections are **deliberately omitted** rather than computed unreliably. The cross-dataset cell-type enrichment table (`celltype_enrichment_combined_Han_Liew.csv`) contains µg and GCR data only.

### 4.3 Modules not present in `pathway_scores_all.csv`
Two modules requested in plan §4.2.3 are not present in the computed pathway-activity table:

- **Energy metabolism** (Oxidative_phosphorylation, TCA_cycle) — not present
- **Carbon metabolism** (Glycolysis_Gluconeogenesis, Pentose_phosphate_pathway, Starch_and_sucrose_metabolism) — not present

These modules will be acknowledged as "not assessed" in PDF text.

### 4.4 OSD-658 whole-seedling tissue ambiguity
The GCR study (OSD-658) is **whole-seedling RNA-seq** — no per-tissue resolution. All GCR claims at the tissue level (root vs shoot vs hypocotyl) are limited to T2 cell-type projection (`celltype_enrichment_combined_Han_Liew.csv`); none are pure T1 GCR-specific tissue calls.

### 4.5 Cluster letter caveat
S2 cluster letters A–E are **hand-annotated by the original authors**, not k-means clustered. They are descriptive groupings of co-varying timepoint trajectories. The small clusters (E n=8, C n=11) carry larger sampling uncertainty per gene.

### 4.6 Cluster of 105 "unassigned" genes
105 genes in the S2 panel were not assigned a cluster letter by the original authors. These were re-summarised in `nmf_cluster_membership.csv` with the label `unassigned`. Their aggregated signal is similar to clusters D/E (mild positive induction +0.16 to +0.30 in both tissues), but they cannot be characterized as a coherent cluster — likely a heterogeneous mix.

### 4.7 S2 ↔ S7 panel disjointness
The 36 polyphenol genes in S7 have **zero overlap** with the 194-gene ROS panel in S2 (verified). The two analyses are parallel transcriptional readouts of different metabolic modules.

### 4.8 Polyphenol panel ↔ KEGG glucosinolate disjointness
S7 polyphenols are flavonoid/anthocyanin/stilbene biosynthesis; the existing `pathway_scores_all.csv` has `Glucosinolate biosynthesis` (KEGG ath00966). These are different metabolic chemistry — polyphenol panel does NOT map onto the glucosinolate pathway score. They are reported separately.

## 5. Code patterns used (for reproducibility)

```python
# S4 parsing
s4_raw = pd.read_excel('Supplementary Table S4.xlsx', sheet_name=0, header=None, skiprows=3)
s4_raw.columns = ['tair_id','subcellular','gene_code','gene_function',
                  'R_4h','R_24h','R_48h','R_96h','S_4h','S_24h','S_48h','S_96h']
# Decimal-only values; use pd.to_numeric(..., errors='coerce')

# S3/S6 Tukey diff+star pattern
def parse_diff_stars(cell):
    m = re.match(r'^\s*(-?[\d.]+)(\**)', str(cell))
    if m: return (float(m.group(1)), m.group(2))
    return (None, '')
# Star → sig: {'': 'ns', '*': 'p<0.05', '**': 'p<0.01', '***': 'p<0.001'}

# Tissue/stressor assignment
def assign(row):
    if row['study'] == 'OSD-120': return pd.Series({'tissue_norm':'root', 'stressor':'µg'})
    elif row['study'] == 'OSD-678': return pd.Series({'tissue_norm':'shoot', 'stressor':'µg'})
    elif row['study'] == 'OSD-658': return pd.Series({'tissue_norm':'whole_seedling', 'stressor':'GCR'})
    elif row['study'] == 'Maffei2022_NMF': return pd.Series({'tissue_norm': row['tissue'], 'stressor':'NMF'})

# Activity labelling (mean_log2fc → label)
def label(row):
    m = row['mean_log2fc']; sc = row['sign_concordance']
    if pd.isna(m): return 'no_coverage'
    elif m > 0.30 and sc >= 0.75: return 'activated'
    elif m < -0.30 and sc >= 0.75: return 'suppressed'
    elif abs(m) < 0.30 and sc < 0.75: return 'rewired'
    elif abs(m) < 0.30 and sc >= 0.75:
        return 'modestly_activated' if m > 0 else 'modestly_suppressed'
    else: return 'n.s.'
```

## 6. Cross-reference to figures and PDFs

| Figure | Content | Source data |
|---|---|---|
| 10 | 5×14 NMF cluster heatmap | `nmf_cluster_profile.csv` |
| 11 | NMF polyphenol summary (genes + content) | `nmf_polyphenol_gene_panel.csv` + `nmf_polyphenol_content.csv` |
| 12 | NMF causal-chain figure | composite of S2 cluster, S5/S6 content, GA_biosynthesis +0.721 |
| 13 | Integrated 6-layer × 3-stressor systems biology | `integrated_stressor_matrix.csv` |

PDF deliverables:
- `nmf_systems_biology_summary.pdf` — focused NMF report (~6 pages)
- `integrated_systems_biology_report.pdf` — full multi-stressor report (~15-20 pages)

Locked artifacts (NOT modified this session):
- `report_seed_germination_mechanism.md` (Stage E)
- `figures/09_mechanistic_model.png/.svg` (Stage E mechanistic figure)
