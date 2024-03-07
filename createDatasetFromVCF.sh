#!/bin/bash

# Paths to data files (ADD YOUR OWN PATH HERE!)
VCF=~/public/1000Genomes/ALL.chr21.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
SAMPLEINFO=~/public/1000Genomes/igsr_samples.tsv

# Output prefix to use
PREFIX=example_data_
#############################################################

# Step 1: Extract samples from the CEU, PEL, GWD, ASW, and PUR populations.
# These are in SAMPLEINFO (igsr_samples.tsv). 
# Not all samples in that file are included in our VCF.
# We can restrict to samples listed as "Genomes phase 3 release".
# plink will need a file with 2 columns (family ID and sample ID).
# We do not have a family ID so we will use the sample ID as the family ID
cat ${SAMPLEINFO} |   grep "1000 Genomes phase 3 release" |   awk -F"\t" '($4=="CEU" || $4=="ASW" || $4=="PUR")' | awk '{print $1 "\t" $1}' > temp.txt

# Step 2: Use plink to preprocess the dataset.
# (1) filter variants with MAF<1% (--maf 0.01)
# (2) keep only samples extracted in step 1 (--keep <sample list> --double-id)
# (3) Output a binary plink format (--make-bed)
plink --vcf $VCF --keep temp.txt --double-id --maf 0.01 --chr 21 --make-bed --out ${PREFIX}

# Step 3: Use plink to perform LD-pruning.
# You can use the plink --indep-pairwise option to get a list of 
# variants to include (plink.prune.in)
# Then use plink --extract plink.prune.in --make-bed --out $PREFIX.pruned
# to output a new dataset (example_data.pruned.bed, etc.) with only the pruned variants
# See example in https://dalexander.github.io/admixture/admixture-manual.pdf
plink --bfile $PREFIX --indep-pairwise 50 10 0.1 --out $PREFIX
      
plink --bfile $PREFIX --extract $PREFIX.prune.in --make-bed --out ${PREFIX}.pruned