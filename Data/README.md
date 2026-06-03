
# Data Sources

## NASA GeneLab Datasets

### OSD-120

NASA GeneLab Dataset:
OSD-120  https://osdr.nasa.gov/bio/repo/data/studies/OSD-120

Differential expression file used:

GLDS-120_rna_seq_differential_expression_rRNArm_GLbulkRNAseq.csv

This file was obtained directly from the NASA GeneLab Files section associated with OSD-120.

---

### OSD-678 (GLDS-612)

NASA GeneLab Dataset:
GLDS-612 / OSD-678 https://osdr.nasa.gov/bio/repo/data/studies/OSD-678

Differential expression file used:

GLDS-612_rna_seq_differential_expression_rRNArm_GLbulkRNAseq.csv

This file was obtained directly from the NASA GeneLab Files section associated with OSD-678.

---

## Near-Zero Magnetic Field (NMF) Dataset

NMF expression values were extracted from supplementary files associated with published peer-reviewed research articles.
https://www.mdpi.com/2218-273X/12/12/1824

The supplementary spreadsheets provided normalized expression values used for generation of:

* ROS heatmaps
* Gibberellin heatmaps
* Circadian analyses
* KEGG pathway visualizations

Gene selection was performed manually using gene identifiers reported within the supplementary material.

---

# Obtaining NASA GeneLab Data

1. Navigate to the NASA GeneLab website.

2. Search for the dataset:

   * OSD-120
   * OSD-678 (GLDS-612)

3. Open the dataset page.

4. Select the **Files** tab.

5. Download the differential expression file:

   For OSD-120:

   GLDS-120_rna_seq_differential_expression_rRNArm_GLbulkRNAseq.csv

   For OSD-678:

   GLDS-612_rna_seq_differential_expression_rRNArm_GLbulkRNAseq.csv

6. Place the downloaded file inside your R working directory before running any analysis scripts.

---

# Important Note About Large NASA Files

The GeneLab differential expression tables are large.

Because of repository size limitations, these raw files are not included in this GitHub repository.

Users must download the files directly from NASA GeneLab before reproducing the analyses.

---

# Setting the Working Directory in R

Before running any script, set your working directory to the folder containing the downloaded GeneLab files.

Example:

```r
setwd("C:/Users/your_name/Documents/phyD-spaceflight-analysis/Data")
```

Verify location:

```r
getwd()
```

List available files:

```r
list.files()
```

Confirm the GeneLab file is visible:

```r
list.files(pattern = "GLDS")
```

---

# Loading the Differential Expression File

Example:

```r
expr <- read.csv(
  "GLDS-120_rna_seq_differential_expression_rRNArm_GLbulkRNAseq.csv"
)
```

or

```r
expr <- read.csv(
  "GLDS-612_rna_seq_differential_expression_rRNArm_GLbulkRNAseq.csv"
)
```

---

# Common Error

If R returns:

```r
cannot open file
```

or

```r
No such file or directory
```

the GeneLab file has not been placed inside the active working directory.

Check:

```r
getwd()
list.files()
```

and ensure the downloaded GeneLab file is located in that folder.

---
## Alternative File Loading Method

If the GeneLab file is not located in the working directory, it can be selected manually using:

```r
expr <- read.csv(file.choose())
```

A file browser window will appear allowing the user to navigate to and select the downloaded GeneLab differential expression file.

This method avoids working directory issues and is recommended for new users.
```

## Acknowledgements

Data used in this repository originate from:

* NASA GeneLab
* Published peer-reviewed research articles
* Supplementary datasets associated with the referenced studies


