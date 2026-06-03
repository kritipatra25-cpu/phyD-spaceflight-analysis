Arabidopsis Spaceflight Transcriptomic Analysis

This repository contains reproducible analyses of Arabidopsis thaliana transcriptomic responses to spaceflight conditions using NASA GeneLab dataset GLDS-120 (OSD-120).

The project investigates the relationship between:

Cryptochrome signaling (CRY1, CRY2)
Circadian clock regulation
Reactive Oxygen Species (ROS) signaling
Gibberellin biosynthesis and signaling
Photosynthesis
Photorespiration

The broader goal is to understand how spaceflight-associated environmental conditions influence plant biological networks and to compare these responses with Near Null Magnetic Field (NNMF) datasets.

Dataset

NASA GeneLab:

OSD-120
GLDS-120 RNA-seq differential expression dataset

Analysis Workflow
Extract pathway-specific gene sets.
Generate expression matrices from RNA-seq data.
Export matrices for visualization in Morpheus.
Apply row-wise Z-score normalization.
Perform hierarchical clustering using:
One minus Pearson correlation
Average linkage

Pathways Analyzed
Cryptochrome (CRY)
Circadian Clock
Reactive Oxygen Species (ROS)
Gibberellin Signaling
Photosynthesis
Photorespiration

Software
R
Morpheus (Broad Institute)
