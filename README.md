# Genome-wide rotational and translational setting of transcription factors with nucleosomes

### Haining Chen<sup>&#x2020; 1</sup>, Jordan E. Krebs<sup>&#x2020; 1</sup>,  Olivia W. Lang<sup>1</sup>, Judith H. Lang<sup>1</sup>, Chunliang L. Lai<sup>1</sup>, William K. M. Lai<sup>1</sup>, B. Franklin Pugh<sup>1</sup>

&#x2020; Co-first author

<sup>1</sup>Department of Molecular Biology and Genetics, Cornell University, Ithaca, New York, 14853, USA
<sup>1</sup>Department of Tumor Cell Biology, St. Jude Children’s Research Hospital, Memphis, Tennessee, 38105, USA
### Correspondence:fp265@cornell.edu

### PMID : [XXXXXXXX](https://pubmed.ncbi.nlm.nih.gov/XXXXXXXX/)
### GEO ID : [GSE266547](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE266547)
### GEO ID : [GSE267711](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE267711)

## Abstract
How transcription factors (TFs) access DNA and interface within nucleosomes is key to understanding gene regulation. TFs recognize their DNA binding site (TFBS) either when it is nucleosome-free or its helical site is rotationally accessible on a nucleosome surface. These two access parameters are manifested through translational and rotational phasing of nucleosomes. Measuring phasing on a genomic scale has been limited by the resolution of current assays. Here we develop a nuclease-based assay (Benzonase-seq) to probe translational and rotational phasing across the human genome, and update ChIP-exo (to v6) to measure this phasing on the same DNA molecule to which a TF is bound. The latter uniquely allows phasing to be measured with TFs that bind DNA transiently. We find that human TFBSs show distinct phasing patterns depending on TF occupancy. For example, unbound CTCF sites are encased within DNA-encoded rotationally phased nucleosomes. But there is no consensus translational phasing until CTCF binds. Similar relationships exist with other TFs like ZKSCAN1, and for transiently binding TFs like FoxA and NFIA. Our assays also provide improved maps of nucleosome positions particularly at promoters and resolves subnucleosomal structures. These findings uncover new principles of how TFs engage nucleosomes to shape the genomic chromatin landscape.

## Directions
To recreate the figures for this manuscript, please execute the scripts in each directory in numerical order. Each directory's README includes more specific details on execution. To be more explicit, run the scripts in each directory in the following order: `00_Download_and_Preprocessing`, `01_Run_GenoPipe`, `02_Call_Nucleosomes`, `03_Call_JASPAR`, `04_Call_Motifs`, `X_Bulk_Processing`, and then finally `Z_Figures`.

## Dependencies
Use the following [anaconda](https://anaconda.org/) environment initialization for setting up dependencies

```
conda create -n bx -c bioconda -c conda-forge bedtools bowtie2 bwa cutadapt meme opencv pandas samtools scipy sra-tools wget pybigwig
```

For genetrack-executing script, a python2 environment needed to be created. The create command for that env is as follows:

```
conda create -n genetrack -c conda-forge -c bioconda python=2.7 numpy
```


## Table of Contents

### 00_Download_and_Preprocessing
Perform the preprocessing steps including alignment of raw sequencing data from both novel and previously published data.

### 01_Run_GenoPipe
Perform quality control for genetic background on these data by running GenoPipe on the aligned BAMs.

### 02_Call_Nucleosomes
Call nucleosome positions and identify TSS and +1 nucleosome reference points with different sorts.

### 03_Call_JASPAR
Call JASPAR motifs and subset to "bound" sites using ENCODE peak data.

### 04_Call_Motifs
Build de novo sequence-specific transcription factor (ssTF) motif reference points using Benzonase ChIP-exo data.

### X_Bulk_Processing
With the BAM and BED files built from the scripts in the above directories, perform bulk read pileups for heatmaps and composites.

### Z_Figures
Copy/organize results from bulk processing into figure-specific directories corresponding to subfigures in the manuscript. Also includes custom/one-off scripts for analysis that didn't need bulk-style execution.

### AI_files
all figures in paper

### data
Store large files to be globally accessed by the scripts in each directory

### bin
Generalized scripts and executables for global access by each of the numbered directories.
