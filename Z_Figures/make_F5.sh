#!/bin/bash

# Organize data from X_Bulk_Processing into Z_Figures for F5

### CHANGE ME
WRK=/storage/group/bfp2/default/hxc585_HainingChen/2026_Chen_TF-Nuc/Z_Figures
#WRK=/storage/home/owl5022/scratch/2024-Krebs_Science/Z_Figures
###

set -exo
module load anaconda3
source activate /storage/group/bfp2/default/owl5022-OliviaLang/conda/bx

LIBRARY=$WRK/../X_Bulk_Processing/Library
SCRIPTMANAGER=$WRK/../bin/ScriptManager-v0.15.jar
MOTIF=$WRK/../data/RefPT-Motif

[ -d F5 ] || mkdir F5

# ===============================================================================================================================

[ -d F5/a ] || mkdir F5/a

BED=FOXA_K562-uHepG2_SORT-ClosestDyad_1000bp

# Sequence figs
cp $LIBRARY/WebLogos/FOXA2_M1_logo.eps F5/a/
cp $LIBRARY/$BED/FourColor/${BED}_31bp.svg F5/a/

# Heatmaps
cp $LIBRARY/$BED/SVG/K562_IgG_BX_merge_hg38_${BED}_5read1_Raw_merge_label.svg F5/a/
cp $LIBRARY/$BED/SVG/K562_FOXA2_BX_rep1_hg38_${BED}_5read1_NCIS_merge_label.svg F5/a/
cp $LIBRARY/$BED/SVG/K562_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS_merge_label.svg F5/a/
cp $LIBRARY/$BED/SVG/HepG2_IgG_BX_merge_hg38_${BED}_5read1_Raw_merge_label.svg F5/a/
cp $LIBRARY/$BED/SVG/HepG2_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS_merge_label.svg F5/a/
cp $LIBRARY/$BED/SVG/HepG2_FOXA2_BX_rep1_hg38_${BED}_5read1_NCIS_merge_label.svg F5/a/
cp $LIBRARY/$BED/SVG/BNase-seq_50U-10min_merge_hg38_${BED}_midpoint_TotalTag_combined.svg F5/a/
cp $LIBRARY/$BED/SVG/ATAC-seq_ENCFF077FBI_CTCF_SORT-Occupancy_1000bp_midpoint_TotalTag_combined.svg F5/a/

java -jar $SCRIPTMANAGER coordinate-manipulation expand-bed -c 100 $MOTIF/FOXA_LABEL-K562.bed -o F5/a/FOXA_LABEL-K562_100bp.bed
java -jar $SCRIPTMANAGER coordinate-manipulation expand-bed -c 100 $MOTIF/FOXA_LABEL-uHepG2.bed -o F5/a/FOXA_LABEL-uHepG2_100bp.bed

K562_FOXA1_BAM=$WRK/../data/BAM/K562_FOXA1_BX_rep1_hg38.bam
HEPG2_FOXA1_BAM=$WRK/../data/BAM/HepG2_FOXA1_BX_rep1_hg38.bam
K562_FOXA2_BAM=$WRK/../data/BAM/K562_FOXA2_BX_rep1_hg38.bam
HEPG2_FOXA2_BAM=$WRK/../data/BAM/HepG2_FOXA2_BX_rep1_hg38.bam
K562_IgG_BAM=$WRK/../data/BAM/K562_IgG_BX_merge_hg38.bam

# Tag Pileup and Sum antisense scores
for BAMFILE in $K562_FOXA1_BAM $HEPG2_FOXA1_BAM $K562_FOXA2_BAM $HEPG2_FOXA2_BAM $K562_IgG_BAM ; do
    BAM=`basename $BAMFILE ".bam"`
    NFFILE=$WRK/../data/BAM/NormalizationFactors/$BAM\_NCISb_ScalingFactors.out
    FACTOR=`grep 'Scaling factor' $NFFILE | awk -F" " '{print $3}'`
    java -jar $SCRIPTMANAGER read-analysis tag-pileup F5/a/FOXA_LABEL-K562_100bp.bed $BAMFILE -1 -s 6 --combined --cpu 4 -o  F5/a/${BAM}_FOXA_LABEL-K562_100bp_read1.out
    java -jar $SCRIPTMANAGER read-analysis scale-matrix F5/a/${BAM}_FOXA_LABEL-K562_100bp_read1.out  -s $FACTOR -l 1 -r 1 -o F5/a/${BAM}_FOXA_LABEL-K562_100bp_read1_Normalized.out
    java -jar $SCRIPTMANAGER read-analysis tag-pileup F5/a/FOXA_LABEL-uHepG2_100bp.bed $BAMFILE -1 -s 6 --combined --cpu 4 -o  F5/a/${BAM}_FOXA_LABEL-uHepG2_100bp_read1.out
    java -jar $SCRIPTMANAGER read-analysis scale-matrix F5/a/${BAM}_FOXA_LABEL-uHepG2_100bp_read1.out  -s $FACTOR -l 1 -r 1 -o F5/a/${BAM}_FOXA_LABEL-uHepG2_100bp_read1_Normalized.out
    java -jar $SCRIPTMANAGER read-analysis aggregate-data --sum F5/a/${BAM}_FOXA_LABEL-K562_100bp_read1_Normalized.out -o F5/a/${BAM}_FOXA_LABEL-K562_100bp_read1_SCORES.out
    java -jar $SCRIPTMANAGER read-analysis aggregate-data --sum F5/a/${BAM}_FOXA_LABEL-uHepG2_100bp_read1_Normalized.out -o F5/a/${BAM}_FOXA_LABEL-uHepG2_100bp_read1_SCORES.out
done

# ===============================================================================================================================

[ -d F5/b ] || mkdir F5/b

# Composites
BED=FOXA_LABEL-K562_SORT-ClosestDyad_1000bp
cp $LIBRARY/$BED/Composites/BNase-seq_50U-10min_merge_hg38_${BED}_5read1_TotalTag.out F5/b/
BED=FOXA_LABEL-uHepG2_SORT-ClosestDyad_1000bp
cp $LIBRARY/$BED/Composites/BNase-seq_50U-10min_merge_hg38_${BED}_5read1_TotalTag.out F5/b/

# ===============================================================================================================================

[ -d F5/c ] || mkdir F5/c

# Composites
BED=FOXA_all_SORT-ClosestDyad_GROUP-NFR_1000bp
cp $LIBRARY/$BED/Composites/K562_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out F5/c/
cp $LIBRARY/$BED/Composites/K562_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS.out F5/c/
cp $LIBRARY/$BED/Composites/BNase-seq_50U-10min_merge_hg38_${BED}_midpoint_combined.out   F5/c/
BED=FOXA_all_SORT-ClosestDyad_GROUP-NoOverlap_1000bp
cp $LIBRARY/$BED/Composites/K562_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out F5/c/
cp $LIBRARY/$BED/Composites/K562_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS.out F5/c/
cp $LIBRARY/$BED/Composites/BNase-seq_50U-10min_merge_hg38_${BED}_midpoint_combined.out   F5/c/

# ===============================================================================================================================

[ -d F5/d ] || mkdir F5/d

# Heatmaps
BED=FOXA_K562-uHepG2_SORT-ClosestDyad_1000bp
cp $LIBRARY/$BED/Composites/nativeK562_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/nativeK562_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/K562_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/K562_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/nativeHepG2_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/nativeHepG2_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/HepG2_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/HepG2_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS.out F5/d

# ===============================================================================================================================

[ -d F5/e ] || mkdir F5/e

BED=FOXA_all_SORT-ClosestDyad_GROUP-NFR_1000bp
cp $LIBRARY/$BED/Composites/nativeK562_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/nativeK562_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/KK_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/KK_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/KH_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/KH_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS.out F5/d

BED=FOXA_all_SORT-ClosestDyad_GROUP-NoOverlap_1000bp
cp $LIBRARY/$BED/Composites/nativeK562_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/nativeK562_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/KK_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/KK_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/KH_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out F5/d
cp $LIBRARY/$BED/Composites/KH_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS.out F5/d


