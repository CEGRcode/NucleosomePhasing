#!/bin/bash

# Organize data from X_Bulk_Processing into Z_Figures for S5

### CHANGE ME
WRK=/storage/group/bfp2/default/hxc585_HainingChen/2025_Chen_TF-Nuc/Z_Figures
#WRK=/storage/home/owl5022/scratch/2024-Krebs_Science/Z_Figures
###

set -exo
module load anaconda3
source activate /storage/group/bfp2/default/owl5022-OliviaLang/conda/bx

LIBRARY=$WRK/../X_Bulk_Processing/Library
SCRIPTMANAGER=$WRK/../bin/ScriptManager-v0.15.jar

[ -d S5 ] || mkdir S5
# ===============================================================================================================================

[ -d S5/a ] || mkdir S5/a

# Heatmaps
BED=FOXA_all_SORT-HepG2-Occupancy_1000bp
cp $LIBRARY/$BED/SVG/HepG2_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS_merge_label.svg S5/a/
cp $LIBRARY/$BED/SVG/HepG2_FOXA2_BX_rep1_hg38_${BED}_5read2_NCIS_merge_label.svg S5/a/
cp $LIBRARY/$BED/FourColor/*.svg S5/a/

# ===============================================================================================================================

[ -d S5/b ] || mkdir S5/b
##heatmap
cp $LIBRARY/10phase/FOXA_LABEL-uHepG2_SORT-ClosestDyad/BNase-seq_50U-10min_merge_hg38_FOXA_LABEL-uHepG2_SORT-ClosestDyad_nearNuc_read1_shuffle_250bp_phase_sort_merge.svg S5/b/
cp $LIBRARY/10phase/FOXA_LABEL-uHepG2_SORT-ClosestDyad/BNase-seq_50U-10min_merge_hg38_FOXA_LABEL-uHepG2_SORT-ClosestDyad_nearNuc_read1_original_250bp_phase_sort_merge.svg S5/b/
# Composites
cp $LIBRARY/10phase/FOXA_LABEL-uHepG2_SORT-ClosestDyad/10xplot/BNase-seq_50U-10min_merge_hg38_FOXA_LABEL-uHepG2_SORT-ClosestDyad_nearNuc_read1_original_phase_2.out S5/b/
cp $LIBRARY/10phase/FOXA_LABEL-uHepG2_SORT-ClosestDyad/10xplot/BNase-seq_50U-10min_merge_hg38_FOXA_LABEL-uHepG2_SORT-ClosestDyad_nearNuc_read1_original_phase_0.out S5/b/
cp $LIBRARY/10phase/FOXA_LABEL-uHepG2_SORT-ClosestDyad/10xplot/BNase-seq_50U-10min_merge_hg38_FOXA_LABEL-uHepG2_SORT-ClosestDyad_nearNuc_read1_shuffle_phase_2.out S5/b/
cp $LIBRARY/10phase/FOXA_LABEL-uHepG2_SORT-ClosestDyad/10xplot/BNase-seq_50U-10min_merge_hg38_FOXA_LABEL-uHepG2_SORT-ClosestDyad_nearNuc_read1_shuffle_phase_0.out S5/b/
# ===============================================================================================================================
[ -d S5/c ] || mkdir S5/c
cp $LIBRARY/10phase/FOXA_phase_aligned/*.out S5/c/

# ===============================================================================================================================
[ -d S5/d ] || mkdir S5/d
# Composites
BED=FOXA_all_SORT-ClosestDyad_GROUP-NucOverlap_1000bp
cp $LIBRARY/$BED/Composites/K562_FOXA2_BX_rep1_hg38_${BED}_5read1_NCIS.out S5/d/
cp $LIBRARY/$BED/Composites/K562_FOXA2_BX_rep1_hg38_${BED}_5read2_NCIS.out S5/d/
BED=FOXA_all_SORT-ClosestDyad_GROUP-NFR_1000bp
cp $LIBRARY/$BED/Composites/K562_FOXA2_BX_rep1_hg38_${BED}_5read1_NCIS.out S5/d/
cp $LIBRARY/$BED/Composites/K562_FOXA2_BX_rep1_hg38_${BED}_5read2_NCIS.out S5/d/
BED=FOXA_K562-uHepG2_SORT-ClosestDyad_1000bp
cp $LIBRARY/$BED/Composites/HepG2_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out S5/d/
cp $LIBRARY/$BED/Composites/HepG2_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS.out S5/d/
cp $LIBRARY/$BED/Composites/HepG2_FOXA2_BX_rep1_hg38_${BED}_5read1_NCIS.out S5/d/
cp $LIBRARY/$BED/Composites/HepG2_FOXA2_BX_rep1_hg38_${BED}_5read2_NCIS.out S5/d/
# ===============================================================================================================================
[ -d S5/e ] || mkdir S5/e
# Composites
BED=FOXA_all_SORT-ClosestDyad_GROUP-NucOverlap_1000bp
cp $LIBRARY/$BED/Composites/K562_FOXA1_BX_rep1_hg38_${BED}_5read1-MIN100_NCIS.out S5/e/
cp $LIBRARY/$BED/Composites/K562_FOXA1_BX_rep1_hg38_${BED}_5read2-MIN100_NCIS.out S5/e/
BED=FOXA_all_SORT-ClosestDyad_GROUP-NFR_1000bp
cp $LIBRARY/$BED/Composites/K562_FOXA1_BX_rep1_hg38_${BED}_5read1-MIN100_NCIS.out S5/e/
cp $LIBRARY/$BED/Composites/K562_FOXA1_BX_rep1_hg38_${BED}_5read2-MIN100_NCIS.out S5/e/

# ===============================================================================================================================

[ -d S5/f ] || mkdir S5/f

# Heatmaps
BED=FOXA_HepG2_SORT-ClosestHNF4A_1000bp
cp $LIBRARY/$BED/SVG/HepG2_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS_merge_label.svg S5/f/
cp $LIBRARY/$BED/SVG/HepG2_FOXA1_BX_rep1_hg38_${BED}_5read2_NCIS_merge_label.svg S5/f/
cp $LIBRARY/$BED/SVG/HepG2_HNF4A_BX_rep1_hg38_${BED}_5read1_NCIS_merge_label.svg S5/f/

## motif alignment

java -jar $SCRIPTMANAGER coordinate-manipulation expand-bed -c 20 $WRK/../04_Call_Motifs/temp-5_FoxA_motif/HNF4A_bound-HepG2_SORT-Genomic.bed -o S5/f/HNF4A_bound-HepG2_20bp.bed
java -jar $SCRIPTMANAGER coordinate-manipulation expand-bed -c 20 $WRK/../04_Call_Motifs/temp-5_FoxA_motif/HNF4A_unbound-HepG2_SORT-Genomic.bed -o S5/f/HNF4A_unbound-HepG2_20bp.bed
java -jar $SCRIPTMANAGER peak-analysis peak-align-ref  -o S5/f/HNF4A_bound-HepG2_20bp_FOXA_HepG2_SORT-ClosestHNF4A_1000bp S5/f/HNF4A_bound-HepG2_20bp.bed $WRK/../data/RefPT-Motif/1000bp/FOXA_HepG2_SORT-ClosestHNF4A_1000bp.bed
java -jar $SCRIPTMANAGER peak-analysis peak-align-ref  -o S5/f/HNF4A_unbound-HepG2_20bp_FOXA_HepG2_SORT-ClosestHNF4A_1000bp S5/f/HNF4A_unbound-HepG2_20bp.bed $WRK/../data/RefPT-Motif/1000bp/FOXA_HepG2_SORT-ClosestHNF4A_1000bp.bed
java -jar $SCRIPTMANAGER figure-generation heatmap -a 1 -c bf00fc S5/f/HNF4A_bound-HepG2_20bp_FOXA_HepG2_SORT-ClosestHNF4A_1000bp_combined.cdt -o S5/f/HNF4A_bound-HepG2_20bp_FOXA_HepG2_SORT-ClosestHNF4A_1000bp.png
java -jar $SCRIPTMANAGER figure-generation heatmap -a 1 -c bfbfbf S5/f/HNF4A_unbound-HepG2_20bp_FOXA_HepG2_SORT-ClosestHNF4A_1000bp_combined.cdt -o S5/f/HNF4A_unbound-HepG2_20bp_FOXA_HepG2_SORT-ClosestHNF4A_1000bp.png
java -jar $SCRIPTMANAGER figure-generation merge-heatmap S5/f/HNF4A_bound-HepG2_20bp_FOXA_HepG2_SORT-ClosestHNF4A_1000bp.png S5/f/HNF4A_unbound-HepG2_20bp_FOXA_HepG2_SORT-ClosestHNF4A_1000bp.png -o S5/f/HNF4A_HepG2_20bp_FOXA_HepG2_SORT-ClosestHNF4A_1000bp.png
java -jar $SCRIPTMANAGER figure-generation label-heatmap S5/f/HNF4A_HepG2_20bp_FOXA_HepG2_SORT-ClosestHNF4A_1000bp.png -f 20 -l -500 -m 0 -r 500 -o S5/f/HNF4A_HepG2_20bp_FOXA_HepG2_SORT-ClosestHNF4A_1000bp.svg
rm *S5/f/*.png


[ -d S5/g ] || mkdir S5/g
# Composites
BED=FOXA_bound-HepG2_SORT-ClosestHNF4A-bound_Group-Distal_1000bp
cp $LIBRARY/$BED/Composites/HepG2_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out S5/g/
cp $LIBRARY/$BED/Composites/HepG2_HNF4A_BX_rep1_hg38_${BED}_5read1_NCIS.out S5/g/

BED=FOXA_bound-HepG2_SORT-ClosestHNF4A-bound_Group-Proximal_1000bp
cp $LIBRARY/$BED/Composites/HepG2_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out S5/g/
cp $LIBRARY/$BED/Composites/HepG2_HNF4A_BX_rep1_hg38_${BED}_5read1_NCIS.out S5/g/

BED=HNF4A_bound-HepG2_SORT-ClosestFOXA-bound_Group-Distal_1000bp
cp $LIBRARY/$BED/Composites/HepG2_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out S5/g/
cp $LIBRARY/$BED/Composites/HepG2_HNF4A_BX_rep1_hg38_${BED}_5read1_NCIS.out S5/g/

BED=HNF4A_bound-HepG2_SORT-ClosestFOXA-bound_Group-Proximal_1000bp
cp $LIBRARY/$BED/Composites/HepG2_FOXA1_BX_rep1_hg38_${BED}_5read1_NCIS.out S5/g/
cp $LIBRARY/$BED/Composites/HepG2_HNF4A_BX_rep1_hg38_${BED}_5read1_NCIS.out S5/g/

##
