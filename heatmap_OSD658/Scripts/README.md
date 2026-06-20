# OSD-658 Heatmap Analysis

## Overview

This directory contains pathway-focused transcriptomic analyses derived from the NASA GeneLab OSD-658 dataset.

OSD-658 investigates Arabidopsis thaliana seed germination under Galactic Cosmic Radiation (GCR) exposure conditions. The analyses in this folder focus on biological pathways associated with germination, stress responses, and developmental regulation.

## Folder Structure

### Results/

Contains heatmaps generated using Morpheus for key biological modules:

- **GCR_ABA_Morpheus.heatmap.png**
  - Abscisic Acid (ABA) signaling and dormancy-related genes

- **GCR_Circadian_Morpheus.heatmap.png**
  - Circadian clock and photoperiod-associated genes

- **GCR_Gibberellin_Morpheus.heatmap.png**
  - Gibberellin biosynthesis and signaling genes involved in germination and growth

- **GCR_ROS_Morpheus.heatmap.png**
  - Reactive Oxygen Species (ROS) metabolism and oxidative stress response genes

### Scripts/

Contains R scripts used to generate the pathway-specific heatmaps:

- `GCR_ABA_heatmap.R`
- `GCR_Circadian_heatmap.R`
- `GCR_Gibberellin_heatmap.R`
- `GCR_ROS_heatmap.R`

## Biological Context

These analyses were performed to investigate how exposure to Galactic Cosmic Radiation influences:

- Hormone signaling
- Oxidative stress responses
- Circadian regulation
- Seed germination pathways

The resulting heatmaps were later integrated with additional datasets (OSD-120, OSD-678, and Null Magnetic Field studies) for systems biology modelling and cross-dataset analysis.

## Related Project Components

For integrated systems biology interpretations and final project conclusions, see the `Biomni/` directory in the repository.

## Dataset

NASA GeneLab:
- OSD-658 – Arabidopsis thaliana seed germination under Galactic Cosmic Radiation exposure.
