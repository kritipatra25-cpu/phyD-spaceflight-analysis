#################################################
# 01_setup_packages.R
# Install and load required packages
#################################################
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
    "RColorBrewer",
    "tidyverse"
))

library(SBGNview)
library(tidyverse)
library(org.At.tair.db)
library(AnnotationDbi)
library(xml2)
library(rsvg)
library(RColorBrewer)
