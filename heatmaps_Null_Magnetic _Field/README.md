# NMF ROS and Gibberellin Heatmaps

## Overview

This directory contains reproducible analyses of reactive oxygen species (ROS)-related genes and gibberellin (GA)-related genes from a null magnetic field (NMF) experiment in *Arabidopsis thaliana*.

The analyses were performed using expression data extracted from the supplementary datasets associated with:

**Maffei et al. (2022)**
*Biomolecules* 12(12):1824
https://www.mdpi.com/2218-273X/12/12/1824

The original supplementary files were downloaded directly from the publication website and processed in R to generate time-series heatmaps.

---

## Data Source

### Supplementary Dataset

The analyses use:

**Supplementary Table S2.xlsx**

contained within the supplementary archive:

```text
biomolecules-12-01824-s001.zip
```

Supplementary Table S2 contains expression profiles of oxidative-reaction-associated genes measured under null magnetic field (NMF) conditions.

---

## Gene Sets Analysed

### ROS (Reactive Oxygen Species)

The following ROS-associated genes were extracted from Supplementary Table S2:

* APX1
* APX2
* CAT1
* CCS
* SOD1
* SOD2
* RBOHC
* RBOHG
* RBOHH
* RBOHJ

These genes were selected because they participate in ROS generation, ROS scavenging, and oxidative stress signalling.

---

### Gibberellin Signalling

The following gibberellin biosynthesis genes were extracted from Supplementary Table S2:

* GA20OX3
* GA20OX4
* GA3OX1

These genes are key enzymes involved in gibberellin biosynthesis and regulation.

---

## Experimental Design

Expression measurements are reported for:

### Root tissue

* 10 min
* 1 h
* 2 h
* 4 h
* 24 h
* 48 h
* 96 h

### Shoot tissue

* 10 min
* 1 h
* 2 h
* 4 h
* 24 h
* 48 h
* 96 h

The heatmaps preserve the original temporal order of the experiment.

Columns are displayed in chronological order rather than clustered by expression similarity to maintain biological interpretation of the time-series response.

---

## Heatmap Generation

Heatmaps were generated in R using:

* readxl
* pheatmap

Expression values were extracted from the supplementary spreadsheet and converted to numeric form.

Row-wise scaling (`scale = "row"`) was applied to visualise relative expression dynamics for each gene.

Columns were not clustered:

```r
cluster_cols = FALSE
```

This preserves the temporal structure of the NMF experiment.

Rows were hierarchically clustered to identify genes with similar response patterns.

---



## Citation

Maffei ME, Araniti F, Graña E, et al. (2022).

Biomagnetic effects and oxidative signalling responses in Arabidopsis under null magnetic field conditions.

Biomolecules 12(12):1824.
