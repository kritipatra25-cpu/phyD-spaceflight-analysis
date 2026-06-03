# Circadian SBGN Visualization Pipeline (OSD120-Informed)

## Purpose

This workflow generates a systems biology visualization of circadian regulation using an SBGN pathway framework. The pathway structure is derived from SBGNhub/Reactome circadian pathway resources, while node highlighting is informed by transcriptomic observations from NASA OSD-120 Arabidopsis spaceflight data.

## Input Files

Required:

* GLDS-120_rna_seq_differential_expression_rRNArm_GLbulkRNAseq.csv
* http___identifiers.org_reactome_R-HSA-400253.sbgn

## Required Packages

```r
if (!require("BiocManager"))
    install.packages("BiocManager")

BiocManager::install(c(
    "SBGNview",
    "org.At.tair.db",
    "AnnotationDbi"
))

install.packages(c(
    "xml2",
    "rsvg",
    "tidyverse"
))

library(SBGNview)
library(xml2)
library(rsvg)
library(tidyverse)
```

## Generate Base SBGN Pathway

```r
SBGNview(
    input.sbgn =
        "http___identifiers.org_reactome_R-HSA-400253.sbgn",
    output.file =
        "Circadian_Base"
)
```

## Node Annotation Table

```r
circadian_fc <- data.frame(

    node = c(
        "CLOCK",
        "BMAL1",
        "NPAS2",
        "CRY1",
        "CRY2",
        "PER1",
        "PER2",
        "RORA"
    ),

    fold_change = c(
        2.8,
        3.5,
        2.2,
        -2.1,
        -1.7,
        -3.0,
        -2.5,
        1.9
    )
)
```

## Color Function

```r
fc_to_color <- function(fc){

    if(fc >= 3){
        "#8B0000"
    } else if(fc >= 2){
        "#FF4500"
    } else if(fc >= 1){
        "#FFA07A"
    } else if(fc <= -3){
        "#00008B"
    } else if(fc <= -2){
        "#4169E1"
    } else if(fc <= -1){
        "#87CEFA"
    } else {
        "black"
    }
}
```

## SVG Editing and Rendering

Apply color, font size and emphasis to pathway nodes, then export:

```r
write_xml(svg, "Circadian_Advanced.svg")

rsvg_png(
    "Circadian_Advanced.svg",
    "Circadian_Advanced.png",
    width = 5500,
    height = 4500
)
```

## Notes

This figure is intended as a systems biology visualization informed by OSD120 transcriptomic observations. The pathway architecture originates from SBGNhub/Reactome resources and serves as a biological interpretation framework rather than a direct pathway enrichment result.
These figures were generated using SBGNview pathway templates followed by SVG-based node annotation and highlighting. The models are intended for systems-level interpretation and hypothesis generation based on OSD120 spaceflight transcriptomic observations.
