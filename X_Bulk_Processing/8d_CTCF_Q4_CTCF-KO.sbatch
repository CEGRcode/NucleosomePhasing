#!/bin/bash

# CTCF KD vs CTCF control BI

### CHANGE ME
WRK=/storage/group/bfp2/default/hxc585_HainingChen/2025_Chen_TF-Nuc/X_Bulk_Processing

###

# Dependencies
# - bedtools
# - java

set -exo
module load bedtools
module load anaconda3
source activate /storage/group/bfp2/default/owl5022-OliviaLang/conda/bx

# Inputs and outputs
GENOME=$WRK/../data/hg38_files/hg38.fa
Genome=$WRK/../data/hg38_files/hg38.info.txt
BAMDIR=$WRK/../data/BAM
BICTCFKD=$WRK/../data/BAM/SEM_-_BI_CTCFKO_hg38.bam
BICTCFControl=$WRK/../data/BAM/SEM_-_BI_WT_hg38.bam
WT_SEM_CTCFBAMFILE=$WRK/../data/BAM/SEM_CTCF_BX_WT_hg38.bam
CTCFKD_SEM_CTCFBAMFILE=$WRK/../data/BAM/SEM_CTCF_BX_CTCTKO_hg38.bam
BLACKLIST=$WRK/../data/hg38_files/ENCFF356LFX_hg38_exclude.bed
BEDDIR=$WRK/../data/RefPT-JASPAR-nonK562/
DIR=$WRK/Library/CTCF_MA1929.1

# cd to data file
cd $WRK/
# Script shortcuts

SCRIPTMANAGER=$WRK/../bin/ScriptManager-v0.15.jar
COMPOSITE=$WRK/../bin/sum_Col_CDT.pl

## Create output directories
[ -d $DIR ] || mkdir $DIR
[[ -d $DIR/SCORES ]] || mkdir $DIR/SCORES

## pile up

for file in $WT_SEM_CTCFBAMFILE  $CTCFKD_SEM_CTCFBAMFILE    ; do
    BAM=`basename $file ".bam"`
    NFFILE=$BAMDIR/NormalizationFactors/$BAM\_TotalTag_ScalingFactors.out
    FACTOR=`grep 'Scaling factor' $NFFILE | awk -F" " '{print $3}'`
    java -jar $SCRIPTMANAGER read-analysis tag-pileup $BEDDIR/1000bp/CTCF_MA1929.1_1_KO-depleted_1000bp.bed $file  --cpu 4 -1 -o $DIR/${BAM}_CTCF_MA1929.1_1_KO-depleted_1000bp_read1.out
    java -jar $SCRIPTMANAGER read-analysis tag-pileup $BEDDIR/1000bp/CTCF_MA1929.1_1_KO-nondepleted_1000bp.bed $file --cpu 4 -1 -o $DIR/${BAM}_CTCF_MA1929.1_1_KO-nondepleted_1000bp_read1.out
    java -jar $SCRIPTMANAGER read-analysis scale-matrix $DIR/${BAM}_CTCF_MA1929.1_1_KO-depleted_1000bp_read1.out  -s $FACTOR -r 1 -l 1 -o $DIR/${BAM}_CTCF_MA1929.1_1_KO-depleted_1000bp_read1_Normalized.out
    java -jar $SCRIPTMANAGER read-analysis scale-matrix $DIR/${BAM}_CTCF_MA1929.1_1_KO-nondepleted_1000bp_read1.out  -s $FACTOR -r 1 -l 1 -o $DIR/${BAM}_CTCF_MA1929.1_1_KO-nondepleted_1000bp_read1_Normalized.out
    rm $DIR/${BAM}_CTCF_MA1929.1_1_KO-depleted_1000bp_read1.out $DIR/${BAM}_CTCF_MA1929.1_1_KO-nondepleted_1000bp_read1.out
done

for file in $WT_SEM_CTCFBAMFILE  $CTCFKD_SEM_CTCFBAMFILE    ; do
    BAM=`basename $file ".bam"`
    NFFILE=$BAMDIR/NormalizationFactors/$BAM\_TotalTag_ScalingFactors.out
    FACTOR=`grep 'Scaling factor' $NFFILE | awk -F" " '{print $3}'`
    java -jar $SCRIPTMANAGER read-analysis tag-pileup $BEDDIR/150bp/CTCF_MA1929.1_1_KO-depleted_150bp.bed $file  --cpu 4 -s 6 -1 --combined -M $DIR/${BAM}_CTCF_MA1929.1_1_KO-depleted_150bp_read1
    java -jar $SCRIPTMANAGER read-analysis tag-pileup $BEDDIR/150bp/CTCF_MA1929.1_1_KO-nondepleted_150bp.bed $file --cpu 4 -s 6 -1 --combined -M $DIR/${BAM}_CTCF_MA1929.1_1_KO-nondepleted_150bp_read1
    java -jar $SCRIPTMANAGER read-analysis scale-matrix $DIR/${BAM}_CTCF_MA1929.1_1_KO-depleted_150bp_read1_combined.cdt  -s $FACTOR  -o $DIR/${BAM}_CTCF_MA1929.1_1_KO-depleted_150bp_read1_combined_Normalized.cdt
    java -jar $SCRIPTMANAGER read-analysis scale-matrix $DIR/${BAM}_CTCF_MA1929.1_1_KO-nondepleted_150bp_read1_combined.cdt  -s $FACTOR  -o $DIR/${BAM}_CTCF_MA1929.1_1_KO-nondepleted_150bp_read1_combined_Normalized.cdt
    java -jar "$SCRIPTMANAGER" read-analysis aggregate-data --sum $DIR/${BAM}_CTCF_MA1929.1_1_KO-depleted_150bp_read1_combined_Normalized.cdt -o $DIR/SCORES/${BAM}_CTCF_MA1929.1_1_KO-depleted_150bp_read1_combined_Normalized.out
    java -jar "$SCRIPTMANAGER" read-analysis aggregate-data --sum $DIR/${BAM}_CTCF_MA1929.1_1_KO-nondepleted_150bp_read1_combined_Normalized.cdt -o $DIR/SCORES/${BAM}_CTCF_MA1929.1_1_KO-nondepleted_150bp_read1_combined_Normalized.out
    rm $DIR/${BAM}_CTCF_MA1929.1_1_KO-depleted_150bp_read1_combined.cdt $DIR/${BAM}_CTCF_MA1929.1_1_KO-nondepleted_150bp_read1_combined.cdt
    rm $DIR/${BAM}_CTCF_MA1929.1_1_KO-depleted_150bp_read1_combined_Normalized.cdt $DIR/${BAM}_CTCF_MA1929.1_1_KO-nondepleted_150bp_read1_combined_Normalized.cdt
done

for file in $BICTCFKD  $BICTCFControl ; do
    BAM=`basename $file ".bam"`
    NFFILE=$BAMDIR/NormalizationFactors/$BAM\_TotalTag_ScalingFactors.out
    FACTOR=`grep 'Scaling factor' $NFFILE | awk -F" " '{print $3}'`
    java -jar "$SCRIPTMANAGER" read-analysis aggregate-data --sum $DIR/${BAM}_CTCF_MA1929.1_1_KO-depleted_150bp_midpoint_combined.cdt -o $DIR/SCORES/${BAM}_CTCF_MA1929.1_1_KO-depleted_150bp_midpoint_combined.out
    java -jar "$SCRIPTMANAGER" read-analysis aggregate-data --sum $DIR/${BAM}_CTCF_MA1929.1_1_KO-nondepleted_150bp_midpoint_combined.cdt -o $DIR/SCORES/${BAM}_CTCF_MA1929.1_1_KO-nondepleted_150bp_midpoint_combined.out
done

for file in $BICTCFKD  $BICTCFControl ; do
    BAM=`basename $file ".bam"`
    java -jar "$SCRIPTMANAGER"  bam-statistics se-stat $file -o $DIR/SCORES/${BAM}.out
done




